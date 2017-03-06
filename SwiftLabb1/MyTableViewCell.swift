//
//  MyTableViewCell.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-02-21.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import UIKit

class MyTableViewCell: UITableViewCell {
    
    public var viewController : UITableViewController?
    var foodQueryIndex : Int?
    var column1 : UILabel!
    var column2 : UILabel!
    var isChecked: Bool = false
    
    @IBOutlet weak var checkbox: UIButton?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        let screenWidth = self.contentView.frame.size.width
        let cellHeight = self.frame.size.height
        
        let rect = CGRect(x: 0, y: 0, width: (5/8)*screenWidth, height: cellHeight)
        column1 = UILabel(frame: rect)
        column1.text = "?"
        self.contentView.addSubview(column1)
    
        let rect2 = CGRect(x: (5/8)*screenWidth, y: 0, width: screenWidth-cellHeight-(5/8)*screenWidth, height: cellHeight)
        column2 = UILabel(frame: rect2)
        column2.text = "??"
        self.contentView.addSubview(column2)
    
    }
    
    @IBAction func onSelectCheckbox(_ sender: UIButton) {
        if !isChecked {
            if FavouritesTableViewController.nrOfSelections < 2 {
                isChecked = true
                let checkedImage = UIImage(named: "checkbox_checked.png")
                checkbox?.setImage(checkedImage, for: .normal)
                FavouritesTableViewController.nrOfSelections += 1
                if let vc = self.viewController as? FavouritesTableViewController {
                    if FavouritesTableViewController.nrOfSelections == 2 {
                        vc.selectedFoodIndex2 = self.foodQueryIndex!
                        vc.selectedFoodName2 = self.column1.text!
                        vc.enableCompareButton()
                    } else {
                        vc.selectedFoodIndex1 = self.foodQueryIndex!
                        vc.selectedFoodName1 = self.column1.text!
                    }
                }
            }
        } else {
            if FavouritesTableViewController.nrOfSelections == 2 {
                if let vc = self.viewController as? FavouritesTableViewController {
                    vc.disableCompareButton()
                }
            }
            isChecked = false
            let uncheckedImage = UIImage(named: "checkbox_unchecked.png")
            checkbox?.setImage(uncheckedImage, for: .normal)
            FavouritesTableViewController.nrOfSelections -= 1
        }
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
