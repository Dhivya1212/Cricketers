//
//  CricketersTableViewCell.swift
//  Cricketers
//
//  Created by Adaikalraj on 11/03/20.
//  Copyright © 2020 Test. All rights reserved.
//

import UIKit

class CricketersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
