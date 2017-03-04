//
//  FetchValues.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-03-02.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import Foundation
import UIKit

class FetchValues {
    
    var nutrients : Nutrients
    let tableView : UITableView
    var nameLabel : UILabel
    let healthyLabel : UILabel
    
    init(foodIndex: Int, tableView: UITableView, nameLabel: UILabel, healthyLabel: UILabel) {
        nutrients = Nutrients()
        self.tableView = tableView
        self.nameLabel = nameLabel
        self.healthyLabel = healthyLabel
        fetch(foodIndex: foodIndex)
    }
    
    func fetch(foodIndex : Int) {
        let urlString = "http://matapi.se/foodstuff/\(foodIndex)"
        let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: safeUrlString!)
        {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                (data: Data?, response: URLResponse?, error: Error?) in
                if let actualData = data {
                    let jsonOptions = JSONSerialization.ReadingOptions()
                    do {
                        if let parsed = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [String: Any] {
                            if let nutrientValuesDictionary = parsed["nutrientValues"] as? [String: Any],
                                let name = parsed["name"] as? String {
                                
                                DispatchQueue.main.async {
                                    self.nameLabel.text = name
                                    for key in self.nutrients.macroKeys {
                                        if let value = nutrientValuesDictionary[key] as? Float {
                                            self.nutrients.macroValues[key]?.1 = value
                                            self.tableView.reloadData()
                                        } else {
                                            NSLog("Could not find nutrient \(key)")
                                        }
                                    }
                                    
                                    for key in self.nutrients.vitaminKeys {
                                        if let value = nutrientValuesDictionary[key] as? Float {
                                            self.nutrients.vitaminValues[key]?.1 = value
                                            self.tableView.reloadData()
                                        } else {
                                            NSLog("Could not find vitamin \(key)")
                                        }
                                    }
                                    
                                    for key in self.nutrients.mineralKeys {
                                        if let value = nutrientValuesDictionary[key] as? Float {
                                            self.nutrients.mineralValues[key]?.1 = value
                                            self.tableView.reloadData()
                                        } else {
                                            NSLog("Could not find mineral \(key)")
                                        }
                                    }
                                    self.healthyLabel.text = "Nyttighet: \(self.nutrients.healthValue)"
                                }
                            }
                        } else {
                            NSLog("Failed to cast from Json.")
                        }
                    } catch let parseError {
                        NSLog("Failed to parse Json: \(parseError)")
                    }
                } else {
                    NSLog("No data received.")
                }
            }
            task.resume()
        } else {
            NSLog("Failed to create URL.")
        }
    }
    
}
