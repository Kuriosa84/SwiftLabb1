//
//  MyTableViewCell.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-02-21.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    var foodQueryIndex : Int?
    var column1 : UILabel!
    var column2 : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let rect = CGRect(x: 0, y: 0, width: 200, height: 50)
        column1 = UILabel(frame: rect)
        column1.text = "?"
        self.contentView.addSubview(column1)
    
        let rect2 = CGRect(x: 200, y: 0, width: 200, height: 50)
        column2 = UILabel(frame: rect2)
        column2.text = "??"
        self.contentView.addSubview(column2)
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
