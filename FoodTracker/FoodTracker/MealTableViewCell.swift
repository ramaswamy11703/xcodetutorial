//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by Sridhar Ramaswamy on 1/28/17.
//  Copyright © 2017 Sridhar Ramaswamy. All rights reserved.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    @IBOutlet weak var myNameLabel: UILabel!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func singleTap(_ sender: UITapGestureRecognizer) {
        print("single tap")
    }
    
    func doubleTap(_ sender: UITapGestureRecognizer) {
        print("double tap")
    }

}
