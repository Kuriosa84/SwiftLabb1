//
//  Favourites.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-03-04.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import Foundation
import UIKit

class Favourites {
    
    let favouritesKey = "favouritesKey"

    var favourites : [(index: Int, name: String, calories: Float)?] = []
    
    var indices : [Int] {
        get {
            let ud = UserDefaults.standard
            if let favourites = ud.array(forKey: favouritesKey) as? [Int] {
                return favourites
            } else {
                return []
            }
        }
    }
    
    init() {
        
    }
    
    func fetchFavourites(tableView: UITableView) {
        favourites = Array(repeating: nil, count: indices.count)
        for (i, foodIndex) in indices.enumerated() {
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
                                    let name = parsed["name"] as? String,
                                    let calories = nutrientValuesDictionary["energyKcal"] as? Float {
                                    DispatchQueue.main.async {
                                        self.favourites[i] = ((index: foodIndex, name: name, calories: calories))
                                        tableView.reloadData()
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
    
    
    func addFavourite(foodIndex: Int) {
        let ud = UserDefaults.standard
        if let favourites = ud.array(forKey: favouritesKey) as? [Int] {
            var varFavourites = favourites
            varFavourites.append(foodIndex)
            ud.set(varFavourites, forKey: favouritesKey)
            ud.synchronize()
        } else {
            ud.set([foodIndex], forKey: favouritesKey)
        }
    }
    
    func removeFavourite(foodIndex: Int) {
        let ud = UserDefaults.standard
        if let favourites = ud.array(forKey: favouritesKey) as? [Int] {
            var varFavourites = favourites
            if let actualIndex = varFavourites.index(of: foodIndex) {
                varFavourites.remove(at: actualIndex)
            }
            ud.set(varFavourites, forKey: favouritesKey)
            ud.synchronize()
        }
    }
    
    func isInFavourites(index: Int) -> Bool {
        let ud = UserDefaults.standard
        if let favourites = ud.array(forKey: favouritesKey) as? [Int] {
            return favourites.contains(index)
        } else {
            return false
        }
    }
    
}
