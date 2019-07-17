//
//  SecondViewController.swift
//  companion
//
//  Created by Alex Maltsev on 7/14/19.
//  Copyright © 2019 Alex Maltsev. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		showUserInfo()
    }
    
    @IBOutlet weak var personalPhoto: UIImageView!
    
    var userData: JSON?
    
    func showUserInfo() {
        let imageUrl = URL(string: userData!["image_url"].string!)
        if let photoData = try? Data(contentsOf: imageUrl!) {
            personalPhoto.image = UIImage(data: photoData)
        } else {
            print("Bad access to intra server.")
        }
    }

}
