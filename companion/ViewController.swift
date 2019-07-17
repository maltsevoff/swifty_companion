//
//  ViewController.swift
//  companion
//
//  Created by Alex Maltsev on 7/9/19.
//  Copyright © 2019 Alex Maltsev. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

	@IBAction func searchButton(_ sender: UIButton) {
		if userNameField.text != "" {
			userLogin = userNameField.text!
            userInfo()
		} else {
            alertManger(title: "Error", subtitle: "Fill login field.")
		}
	}
	
	@IBOutlet weak var userNameField: UITextField!
    
	override func viewDidLoad() {
		super.viewDidLoad()
		authUsingIntra()
	}

    var response: JSON?
    
	func authUsingIntra () {
		let myData = MyData.init()
		let reqUrl = myData.site +  "oauth/token?grant_type=client_credentials&client_id=\(myData.uid)&client_secret=\(myData.secretKey)"
		
		request(reqUrl, method: .post).authenticate(user: myData.uid, password: myData.secretKey)
			.responseJSON { response in
				if response.data != nil {
					do {
						let dict = try JSONSerialization.jsonObject(with: response.data!, options: []) as! [String: Any]
						guard let token = dict["access_token"] as? String else { return }
						bearerToken = token
						print(token)
					} catch (let error) {
						print(error.localizedDescription)
				}
				} else {
					print("Error in response")
				}
		}
	}
    
    func userInfo () {
        let mydata = MyData.init()
        let reqUrl = mydata.site + "v2/users/\(userLogin)"
        let headers = [
            "Authorization": "Bearer " + bearerToken
        ]
        
        request(reqUrl, method: .get, headers: headers).responseJSON {
            response in
            if response.result.isSuccess {
                self.response = JSON(response.value!)
                print(self.response!["displayname"])
                self.performSegue(withIdentifier: "nextView", sender: nil)
            } else {
                self.alertManger(title: "Error", subtitle: "Invalid login. Try again.")
            }
        }
    }
    
    func alertManger(title: String, subtitle: String) {
        let alert = UIAlertController(title: title, message: subtitle, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
	
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "nextView" {
            let destination = segue.destination as! SecondViewController
            destination.userData = self.response
        }
    }
}

