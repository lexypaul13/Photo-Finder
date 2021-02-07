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
        updateUI(userName: photos.user?.username, fullName:photos.user?.name, date: photos.createdAt)
    }
    
    private func updateUI(userName:String?,fullName:String?,date:String?){
        self.userName.text = userName
        self.fullName.text = fullName
        self.date.text = date
    }
    

}
