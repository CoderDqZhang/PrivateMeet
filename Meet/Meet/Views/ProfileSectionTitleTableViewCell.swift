//
//  ProfileSectionTitleTableViewCell.swift
//  Meet
//
//  Created by Zhang on 6/30/16.
//  Copyright © 2016 Meet. All rights reserved.
//

import UIKit

class ProfileSectionTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoBtn: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setData(_ title:String, buttonTitle:String){
        titleLabel.text = title;
        if buttonTitle == "" {
            infoBtn.isHidden = true
        }else{
            infoBtn.isHidden = false
            infoBtn .setTitle(buttonTitle, for: UIControlState())
            
        }
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
