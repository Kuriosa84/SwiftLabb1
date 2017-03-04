//
//  DiagramViewController.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-03-02.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import UIKit
import GraphKit

class DiagramViewController: UIViewController, GKBarGraphDataSource {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let graphFrame : CGRect = CGRect(x: 100, y: 100, width: 200, height: 200)
        let graphView = GKBarGraph(frame: graphFrame)
        
        
        //self.data = [65, 10, 40, 90, 50, 75]
        //self.labels = ["US", "UK", "DE", "PL", "CN", "JP"];
        /*
         graphView.barWidth = 22;
         graphView.barHeight = 140;
         graphView.marginBar = 25;
         graphView.animationDuration = 2.0;
         */
        graphView.dataSource = self;
        view.addSubview(graphView)
        
        graphView.draw()
    }
    
    func numberOfBars() -> Int {
        return 6
    }
    
    func valueForBar(at index: Int) -> NSNumber! {
        return NSNumber(integerLiteral: (10*index))
    }
    
    func titleForBar(at index: Int) -> String! {
        if(index == 0) {
            return "A-vitamin"
        } else if(index == 1) {
            return "Vitamin B1"
        } else {
            return "hej"
        }
    }
    
    func colorForBar(at index: Int) -> UIColor! {
        return (index % 2 == 0 ? UIColor.blue : UIColor.red)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
