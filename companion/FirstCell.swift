//
//  FirstCell.swift
//  companion
//
//  Created by Alex Maltsev on 7/16/19.
//  Copyright © 2019 Alex Maltsev. All rights reserved.
//

import UIKit

class FirstCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

	@IBOutlet weak var fullNameLabel: UILabel!
	
	override func setSelected(_ selected: Bool, animated: Bool) {
		super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
