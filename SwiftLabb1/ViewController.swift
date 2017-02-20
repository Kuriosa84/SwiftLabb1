//
//  ViewController.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-02-14.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func onButton(_ sender: UIButton) {
        smallLabel.text = input.text
    }
    
    @IBOutlet weak var smallLabel: UILabel!
    

    @IBOutlet weak var input: UITextView!
    
    
}

