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

	override func viewDidLoad() {
		super.viewDidLoad()
		authUsingIntra()
		// Do any additional setup after loading the view.
		
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

