//
//  Network Manager .swift
//  Photo Finder
//
//  Created by Alex Paul on 2/4/21.
//

import UIKit

class NetworkManger{
    
    enum EndPoint{
        case photoDetails
        case searchResult
    }
    
    static let shared = NetworkManger()
    private let baseURL: String
    private var  apiKeyPathCompononent :String
    private var imageURL = Photos()
    let cache   = NSCache<NSString, UIImage>()
    
   
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
    
    func downloadImage(from urlString: String, completed: @escaping (UIImage?) -> Void) {  //downloads image
        let cacheKey = NSString(string: urlString) //creates cacheKey to store in image variable
        let imagesBaseURLSTring = imageURL.urls?.thumb ?? "No image"
        
        guard let url = URL(string: imagesBaseURLSTring) else {
            completed(nil)
            return
        }
        
        if let image = cache.object(forKey: cacheKey) {  //check if image is there
            completed(image)
            return
        }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completed(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completed(image)
        }
        task.resume()
    }
    
    
    
    
    private func urlBuilder(endPoint:EndPoint, page:Int?=nil, query:String? = nil)->URL?{
        switch endPoint {
        //https://api.unsplash.com/photos/?client_id=bqiPXuYiURtZALfadZpG1_QTMg55VqTrUOY5f81nC3A&page=1&orderby=latest
        case .photoDetails:
            return URL(string: baseURL + apiKeyPathCompononent + "page=\(page ?? 0)" )
        case .searchResult:
            return URL(string: baseURL + apiKeyPathCompononent + "&query=\(query ?? "nothing")+ &orientation=landscape")
        }
    }
    
    

    
}
