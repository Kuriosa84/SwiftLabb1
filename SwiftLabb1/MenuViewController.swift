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
    
    var searchResult : [String] = []
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            switch identifier {
            case "QuerySegue":
                if let searchQuery = FoodSearchBar.text?.lowercased(),
                   let vc = segue.destination as? QueryTableViewController {
                    vc.query = searchQuery
                }
            default: break
            }
            
        }
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    func search(query : String) {
        searchResult = []
        let urlString = "http://matapi.se/foodstuff?query=\(query)"
        let safeUrlString = urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        if let url = URL(string: safeUrlString!)
        {
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) {
                (data: Data?, response: URLResponse?, error: Error?) in
                if let actualData = data {
                    let jsonOptions = JSONSerialization.ReadingOptions()
                    do {
                        if let parsed = try JSONSerialization.jsonObject(with: actualData, options: jsonOptions) as? [[String: Any]] {
                            //let nutrientValuesDictionary = parsed["nutrientValues"] as? [String: Any],
                            //let calories = nutrientValuesDictionary["energyKcal"] as? Int,
                            DispatchQueue.main.async {
                                for dictionary : [String:Any?] in parsed {
                                    if let foodName = dictionary["name"] as? String {
                                        
                                        self.searchResult.append(foodName)
                                        
                                    } else {
                                        NSLog("Failed to find 'nutrientValues' or 'energyKcal' in json object.")
                                    }
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
