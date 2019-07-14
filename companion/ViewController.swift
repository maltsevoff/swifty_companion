//
//  ViewController.swift
//  companion
//
//  Created by Alex Maltsev on 7/9/19.
//  Copyright © 2019 Alex Maltsev. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

	@IBAction func searchButton(_ sender: UIButton) {
		if userNameField.text != "" {
			userLogin = userNameField.text!
			performSegue(withIdentifier: "nextView", sender: nil)
		} else {
			let alert = UIAlertController(title: "Error", message: "Fill login field.", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
			self.present(alert, animated: true)
		}
	}
	
	@IBOutlet weak var userNameField: UITextField!
	override func viewDidLoad() {
		super.viewDidLoad()
		authUsingIntra()
	}

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
	
}

