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
		let reqUrl = myData.site +  "oauth/authorize?client_id=\(myData.uid)&redirect_uri=\(myData.redirectUrl)&response_type=code"
//		let reqUrl = "https://api.intra.42.fr/oauth/authorize?client_id=\(myData.uid)&redirect_uri=\(myData.redirectUrl)&response_type=code"
		print(myData.uid, myData.redirectUrl, myData.secretKey)
		
//		request(reqUrl, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil)
//			.validate().responseJSON { response in
//				if response.result.value != nil {
//					print(response)
//				} else {
//					print("Error tut")
//				}
		
		request(reqUrl, method: .get).authenticate(user: myData.uid, password: myData.secretKey)
			.responseString { response in
				print(response)
		}
	}
	
}

