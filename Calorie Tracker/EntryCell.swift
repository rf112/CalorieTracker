//
//  EntryCell.swift
//  Calorie Tracker
//
//  Created by Adam on 11/24/16.
//  Copyright (c) 2016 rase. All rights reserved.
//

import UIKit

class EntryCell: UITableViewCell {
    
    // Links labels for tablecell - Adam
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var calorieLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
