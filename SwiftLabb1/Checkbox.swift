//
//  Checkbox.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-03-05.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import Foundation
import UIKit

class Checkbox: UIButton {
    let checkedImage = UIImage(named: "checkbox_checked.png")! as UIImage
    let uncheckedImage = UIImage(named: "checkbox_unchecked.png")! as UIImage
    

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    //xCode demands this initializer
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: .normal)
            } else {
                self.setImage(uncheckedImage, for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        self.addTarget(self, action: #selector(buttonClicked(sender:)), for: UIControlEvents.touchUpInside)
        //self.addTarget(self, action: Selector(("buttonClicked:")), for: UIControlEvents.touchUpInside)
        self.isChecked = false
    }
    
    func buttonClicked(sender: UIButton) {
        if sender == self {
            isChecked = !isChecked
            
        }
    }
}
