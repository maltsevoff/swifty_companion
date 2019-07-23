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

class SecondViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var userSkills: [Skill] = []
    var userProjects: [Project] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == skillsTableView {
            let cell = skillsTableView.dequeueReusableCell(withIdentifier: "Skill") as? SkillCell
            cell?.nameLabel.text = "\(userSkills[indexPath.row].name ?? "No skill") \(userSkills[indexPath.row].level ?? 0.0)"
            cell?.progressBar.progress = (userSkills[indexPath.row].level ?? 0.0) / 21
            return cell!
        } else {
            let cell = projectsTableView.dequeueReusableCell(withIdentifier: "Project") as? ProjectCell
			cell?.titleLabel.text = userProjects[indexPath.row].name
			cell?.detailLabel.text = String(describing: userProjects[indexPath.row].mark!)
            if userProjects[indexPath.row].isValidate! {
                cell?.detailLabel.textColor = .green
            } else {
                cell?.detailLabel.textColor = .red
            }
            return cell!
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var number: Int
        if tableView == skillsTableView {
            number = userSkills.count
        } else {
            number = userProjects.count
        }
        return number
    }
	
    override func viewDidLoad() {
        super.viewDidLoad()
		showUserInfo()
        saveSkills()
		saveProjects()
        skillsTableView.dataSource = self
        skillsTableView.delegate = self
        projectsTableView.dataSource = self
        projectsTableView.delegate = self
    }
    
    @IBOutlet weak var personalPhoto: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var phoneLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var correctionsLabel: UILabel!
    @IBOutlet weak var pointsLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var skillsTableView: UITableView!
    @IBOutlet weak var projectsTableView: UITableView!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    var userData: JSON?
    
    func showUserInfo() {
//        print(userData)
        let imageUrl = URL(string: userData!["image_url"].string!)
        if let photoData = try? Data(contentsOf: imageUrl!) {
            personalPhoto.image = UIImage(data: photoData)
            personalPhoto.layer.borderWidth = 1
            personalPhoto.layer.masksToBounds = false
            personalPhoto.layer.borderColor = UIColor.black.cgColor
            personalPhoto.layer.cornerRadius = personalPhoto.frame.height/2
            personalPhoto.clipsToBounds = true
            personalPhoto.contentMode = .scaleAspectFill
        } else {
            print("Bad access to intra server.")
        }
        fullNameLabel.text = userData!["displayname"].string!
        loginLabel.text = userData!["login"].string!
        let phone = userData!["phone"].string
        if phone == nil {
            phoneLabel.text = "no phone"
        } else {
            phoneLabel.text = phone
        }
        let location = userData!["location"].string
        if location == nil || location == "" {
            locationLabel.text = "Unavailable"
        } else {
            locationLabel.text = location
        }
        let corrections = userData!["correction_point"].int!
        correctionsLabel.text = "Points: \(corrections)"
        let wallet = userData!["wallet"].int!
        pointsLabel.text = "Wallet: \(wallet)"
        let email = userData!["email"].string!
        emailLabel.text = email
        if let level = userData!["cursus_users"][0]["level"].float {
            levelLabel.text = "level: \(level)"
            progressBar.progress = level / 21
        }
    }

    func saveSkills () {
        let skills = userData!["cursus_users"][0]["skills"]
        for skill in skills {
            var sk = Skill.init()
            sk.name = skill.1["name"].string
            sk.level = skill.1["level"].float
            userSkills.append(sk)
        }
    }
	
	func saveProjects () {
		let projects = userData!["projects_users"]
		for proj in projects {
			if proj.1["status"].string == "finished" {
				var pr = Project.init()
				pr.name = proj.1["project"]["name"].string
				pr.mark = proj.1["final_mark"].int
				pr.isValidate = proj.1["validated?"].bool
				userProjects.append(pr)
			}
		}
		print(projects)
	}
}
