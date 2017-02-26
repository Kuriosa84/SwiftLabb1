//
//  NutritionViewController.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-02-25.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import UIKit

class NutritionViewController: UIViewController {
    
    
    @IBOutlet weak var foodNameLabel: UILabel!
    @IBOutlet weak var foodCaloriesLabel: UILabel!
    
    var foodQueryIndex : Int = 1
    
    var foodName = "Banan"
    
    var calories = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        search(query: foodQueryIndex)

        // Do any additional setup after loading the view.
    }

    func search(query : Int) {
        //searchResult = []
        let urlString = "http://matapi.se/foodstuff/\(query)"
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
                            let calories = nutrientValuesDictionary["energyKcal"] as? Int,
                            let name = parsed["name"] as? String {
                                DispatchQueue.main.async {
                                    self.calories = calories
                                    self.foodCaloriesLabel.text = "\(calories) kcal"
                                    self.foodNameLabel.text = "\(name)"
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

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
