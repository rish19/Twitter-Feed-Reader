//
//  MyTableViewCell.swift
//  twitterFeed
//
//  Created by Rishabh Bhandari on 04/06/19.
//  Copyright © 2019 Rishabh Bhandari. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    @IBOutlet weak var myTextView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
