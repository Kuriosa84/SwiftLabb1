//
//  ViewController.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-02-14.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var searchField: UISearchBar!
    @IBOutlet weak var resultView: UITableView!
    @IBOutlet weak var myTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
/*
    @IBAction func search(_ sender: Any) {
        let urlString = "http://matapi.se/foodstuff?query=\(searchField.text?.lowercased())"
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
                                let foodName = parsed["name"] as? String {
                                if let actualText = textView.text {
                                    DispatchQueue.main.async {
                                        textView.text = "\(actualText)\n\(foodName), \(foodNumber), \(calories) kcal"
                                    }
                                }
                            } else {
                                NSLog("Failed to find 'nutrientValues' or 'energyKcal' in json object.")
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


    func lookUpCalories(foodNumber : Int, textView: UITextView) {
        let urlString = "http://matapi.se/foodstuff/\(foodNumber)"
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
                                    let foodName = parsed["name"] as? String {
                                        if let actualText = textView.text {
                                            DispatchQueue.main.async {
                                                textView.text = "\(actualText)\n\(foodName), \(foodNumber), \(calories) kcal"
                                            }
                                    }
                                } else {
                                    NSLog("Failed to find 'nutrientValues' or 'energyKcal' in json object.")
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
    

    
    
    */
}

