//
//  PhotoTableViewController.swift
//  Photo Finder
//
//  Created by Alex Paul on 2/4/21.
//

import UIKit

class PhotoTableViewController: UITableViewController {
    
    var photos = [Photos]()
    var filteredPhotos = [Photos]()
    var page = 1
   
    let searchController = UISearchController(searchResultsController: nil)
    var isSearchBarEmpty: Bool {return searchController.searchBar.text?.isEmpty ?? true}
    var isFiltering: Bool {return searchController.isActive && !isSearchBarEmpty}
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchController()
        configureTableView()
        getPhotoDetails(page: page)
    }
    
    func configureSearchController(){
        navigationController?.navigationBar.prefersLargeTitles = true
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Pictures"
        navigationItem.searchController = searchController
        definesPresentationContext = true
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
      
        if isFiltering{
            return filteredPhotos.count
        }
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

extension PhotoTableViewController:UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        filterContentForSearchText(searchBar.text!, photos)
    }
    
    func filterContentForSearchText(_ searchText: String, _ category: [Photos]){
        NetworkManger.shared.get(.searchResult,page: page, urlString: searchText) { [weak self] (result: Result<[Photos]?, ErroMessage> ) in
            guard let self = self else { return }
            switch result{
            case .success( _):
                self.filteredPhotos = self.photos.filter({ (pictures: Photos) -> Bool in
                return (pictures.id?.lowercased().contains(searchText.lowercased()) ?? false) })
                DispatchQueue.main.async {self.tableView.reloadData()}
            
            case .failure(let error):
                print("No results")
            }
            
        }
        
        
        
    }
    
}
