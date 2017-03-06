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
    
    var foodIndex1 : Int = 1
    var foodIndex2 : Int = 2
    var foodName1 : String = ""
    var foodName2 : String = ""
    var graphView : GKBarGraph?
    var nutrients1 : Nutrients?
    var nutrients2 : Nutrients?
    var labels : [String] = []

    @IBOutlet weak var foodLabel1: UILabel!
    @IBOutlet weak var foodLabel2: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodLabel1.text = foodName1
        foodLabel1.textColor = UIColor.blue
        foodLabel2.text = foodName2
        foodLabel2.textColor = UIColor.red
        
        let screenWidth = self.view.frame.size.width
        let screenHeight = self.view.frame.size.height
        let graphFrame : CGRect = CGRect(x: 0, y: screenHeight/3, width: screenWidth, height: screenHeight/3)
        graphView = GKBarGraph(frame: graphFrame)
        
        let fetcher1 = FetchValues(foodIndex: foodIndex1, tableView: nil, nameLabel: nil, healthyLabel: nil, graphView: graphView)
        let fetcher2 = FetchValues(foodIndex: foodIndex2, tableView: nil, nameLabel: nil, healthyLabel: nil, graphView: graphView)
        
        self.nutrients1 = fetcher1.nutrients
        self.nutrients2 = fetcher2.nutrients
        
        self.labels = (self.nutrients1?.macroKeys)!
        
        //20 är ett magiskt tal. Alohomora!
        graphView!.barWidth = (self.view.frame.width - 20) / (2*CGFloat(labels.count))
        graphView!.marginBar = 0
        graphView!.dataSource = self
        view.addSubview(graphView!)
        
        graphView!.draw()
    }
    
    func numberOfBars() -> Int {
        return 2 * nutrients1!.macroKeys.count
    }
    
    func valueForBar(at index: Int) -> NSNumber! {
        var data : [Double] = Array(repeating: 0, count: 2 * nutrients1!.macroKeys.count)
        var i : Int = 0
        var j : Int = 0
        while i < data.count {
            if let value1 = nutrients1?.macroValues[(nutrients1?.macroKeys[j])!]?.1 {
                data[i] = Double(value1)
            } else {
                data[i] = 0
            }
            i += 1
            if let value2 = nutrients2?.macroValues[(nutrients2?.macroKeys[j])!]?.1 {
                data[i] = Double(value2)
            } else {
                data[i] = 0
            }
            i += 1
            j += 1
        }
        
        return NSNumber(floatLiteral: data[index])
    }
    
    func titleForBar(at index: Int) -> String! {
        if(index % 2 == 0) {
            return self.labels[index / 2]
        } else {
            return ""
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
