//
//  ViewController.swift
//  Photo Finder
//
//  Created by Alex Paul on 2/4/21.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManger.shared.get(.photoDetails,page: 1, urlString: "") { [weak self] (response: DataModel? ) in
            guard self != nil else { return }
            guard let shows = response?.user else {
                return
            }
            print(shows)
            
        }
    }


}

