//
//  PlaceTableViewCell.swift
//  NearBy
//
//  Created by Mohammed Salah on 9/23/17.
//  Copyright © 2017 Mohammed Salah. All rights reserved.
//

import UIKit

class PlaceTableViewCell: UITableViewCell {

    
    @IBOutlet weak var placeImage: UIImageView!
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var placeAddress1: UILabel!
    @IBOutlet weak var placeAddress2: UILabel!
    @IBOutlet weak var placeAddress3: UILabel!
    @IBOutlet weak var placeAddress4: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
