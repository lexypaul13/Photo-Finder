//
//  PhotoTableViewController.swift
//  Photo Finder
//
//  Created by Alex Paul on 2/4/21.
//

import UIKit

class PhotoTableViewController: UITableViewController {
    
    var photos = [Photos]()
    var page = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getPhotoDetails(page: page)
    }
    
    func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func getPhotoDetails(page:Int){
        NetworkManger.shared.get(.photoDetails,page: page, urlString: "") { [weak self] (result: Result<[Photos]?, ErroMessage> ) in
            guard let self = self else { return }
            switch result{
            
            case .success(let photo):
                self.photos = photo ?? []
                DispatchQueue.main.async {self.tableView.reloadData()}
            
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return photos.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 550
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PhotoTableViewCell
        let photo = photos[indexPath.row]
        cell.setTableCell(photo)
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    
}

