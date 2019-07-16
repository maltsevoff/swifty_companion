//
//  SecondViewController.swift
//  companion
//
//  Created by Alex Maltsev on 7/14/19.
//  Copyright © 2019 Alex Maltsev. All rights reserved.
//

import UIKit
import Alamofire

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
		userInfo()
		
    }
	
	
	var userID: String?
	
	func userInfo () {
		let mydata = MyData.init()
		let reqUrl = mydata.site + "v2/users/\(userLogin)"
		let headers = [
			"Authorization": "Bearer " + bearerToken
		]
		
		request(reqUrl, method: .get, headers: headers).responseJSON {
			response in
			print(response)
			do {
				let dict = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String:Any]
				guard let image = dict["image_url"] as? String else { return }
				guard let fullname = dict["displayname"] as? String else { return }
				guard let email = dict["email"] as? String else { return }
				self.userID = dict["id"] as? String
				print("User id", self.userID)
			} catch {
				print("Error")
			}
		}
	}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
