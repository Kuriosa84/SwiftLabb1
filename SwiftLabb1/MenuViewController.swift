//
//  MenuViewController.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-02-25.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var FoodSearchBar: UITextField!
    @IBOutlet weak var apple: UILabel!
    @IBOutlet weak var matematik: UILabel!
    
    var searchResult : [String] = []
    var searchQuery : String = ""
    var animator : UIDynamicAnimator!
    var gravity : UIGravityBehavior!
    var collision : UICollisionBehavior!
    var snap : UISnapBehavior!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        apple.center.y = -20
        apple.center.x = view.center.x
        
        animator = UIDynamicAnimator(referenceView: view)
        
        gravity = UIGravityBehavior(items: [apple])
        animator.addBehavior(gravity)
        
        collision = UICollisionBehavior(items: [apple, matematik])
        animator.addBehavior(collision)
        
        let snapBack = matematik.center
        snap = UISnapBehavior(item: matematik, snapTo: snapBack)
        animator.addBehavior(snap)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case "QuerySegue":
                if let searchQuery = FoodSearchBar.text?.lowercased() {
                    self.searchQuery = searchQuery
                }
                   if let vc = segue.destination as? QueryTableViewController {
                        vc.query = self.searchQuery
                   } else {
                        NSLog("Viewcontrollern finns inte...")
                }
            default: break
            }
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
