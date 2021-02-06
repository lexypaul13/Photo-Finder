//
//  Network Manager .swift
//  Photo Finder
//
//  Created by Alex Paul on 2/4/21.
//

import Foundation

class NetworkManger{
    
    enum EndPoint{
        case photoDetails
        case searchResult
    }
    
    static let shared = NetworkManger()
    private let baseURL:String
    private var  apiKeyPathCompononent :String
    //let cache   = NSCache<NSString, UIImage>()
    
    private init(){
        self.baseURL = "https://api.unsplash.com/photos/?"
        self.apiKeyPathCompononent = "client_id=bqiPXuYiURtZALfadZpG1_QTMg55VqTrUOY5f81nC3A&"
    }
    
    private var jsonDecoder:JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    
    func get<T:Decodable>(_ endPoints: EndPoint, page: Int? = nil, urlString: String, completed:@escaping(T?)->Void){
        guard let url = urlBuilder(endPoint: endPoints,page: page) else {
            print(ErroMessage.invalidURL.rawValue)
            completed(ErroMessage.invalidURL.rawValue as? T)
            return
        }

        let task = URLSession.shared.dataTask(with: url){ data, response, error in
            if let _ = error {
                print(ErroMessage.unableToComplete.rawValue)
                completed(nil)
                return
            }

            guard let response = response as? HTTPURLResponse, response.statusCode==200 else {
                print(ErroMessage.invalidResponse.rawValue)
                return
            }

            guard let data = data else{
                print(ErroMessage.invalidData.rawValue)
                return
            }
            do{
                let apiResponse = try self.jsonDecoder.decode(T.self, from: data)
                DispatchQueue.main.async {
                    completed(apiResponse)
                }

            } catch{
                print(ErroMessage.invalidData.rawValue)
            }
        }
        task.resume()
    }
    
    
    private func urlBuilder(endPoint:EndPoint, page:Int?=nil, query:String? = nil)->URL?{
        switch endPoint {
        
        case .photoDetails:
            return URL(string: baseURL + apiKeyPathCompononent + "&page=\(page ?? 1)" )
       
        case .searchResult:
            return URL(string: baseURL + apiKeyPathCompononent + "&query=\(query ?? "nothing")+ &orientation=landscape")
        }
    }
    
    

    
}
