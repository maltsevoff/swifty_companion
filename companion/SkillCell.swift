//
//  SkillCell.swift
//  companion
//
//  Created by Oleksandr MALTSEV on 7/17/19.
//  Copyright © 2019 Alex Maltsev. All rights reserved.
//

import UIKit

class SkillCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
}
