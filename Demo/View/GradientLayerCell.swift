//
//  MessageCell.swift
//  FadeMessage
//
//  Created by saitjr on 8/7/16.
//  Copyright © 2016 saitjr. All rights reserved.
//

import UIKit

class GradientLayerCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    func setupUI() {
        self.backgroundColor = UIColor.clear()
        self.label.backgroundColor = UIColor.clear()
        self.label.textColor = UIColor.white()
    }
    
    func setLabel(text:String) {
        label.text = text
    }
}
