//
//  PhotoTableViewCell.swift
//  Photo Finder
//
//  Created by Alex Paul on 2/6/21.
//

import UIKit

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
    
    func setTableCell(_ photos:Photos){
        updateUI(userName: photos.user?.username, fullName:photos.user?.name, date: photos.createdAt?.convertToDisplayFormat(), photo: photos.urls?.regular)
    }
    
    private func updateUI(userName:String?,fullName:String?,date:String?,photo:String?){
        self.userName.text = userName
        self.fullName.text = fullName
        self.date.text = date
        downloadImage(photo ?? "")
    }
    
    func downloadImage(_ url:String)  {
        NetworkManger.shared.downloadImage(from:url){ [weak self] image in
               guard let self = self else { return }
               DispatchQueue.main.async {
                self.photoImage.image = image
               }
            
        }
    }

}
