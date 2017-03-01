//
//  QueryTableViewController.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-02-25.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import UIKit

class QueryTableViewController: UITableViewController {
    
    var query : String?
    
    var searchResult : [(String, Int)] = []
    var calories : [Int : Int] = [:]
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        if let actualQuery = query {
            searchBar.text = actualQuery
            search(query: actualQuery)
            /*
            for tuppel in searchResult {
                getCalories(query: tuppel.1)
            }
             */
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    @IBAction func onNewSearch(_ sender: UIBarButtonItem) {
        if let newQuery = searchBar.text {
            NSLog("Trying to search with query %@", newQuery)
            search(query: newQuery)
        } else {
            NSLog("Search failed...")
        }
    }
    
    @IBAction func onSearchButton(_ sender: Any) {
        
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
                            DispatchQueue.main.async {
                                for dictionary in parsed {
                                    if let foodName = dictionary["name"] as? String,
                                        let foodNumber = dictionary["number"] as? Int
                                        {
                                        self.searchResult.append((foodName,foodNumber))
                                            self.getCalories(query: foodNumber)
                                    } else {
                                        NSLog("Failed to find 'nutrientValues' or 'energyKcal' in json object.")
                                    }
                                }
                                self.tableView.reloadData()
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
    
    func getCalories(query : Int) {
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
                            DispatchQueue.main.async {
                                if let nutritionDictionary = parsed["nutrientValues"] as? [String : Int],
                                    let calorieValue = nutritionDictionary["energyKcal"] {
                                    self.calories[query] = calorieValue
                                    self.tableView.reloadData()
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
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased() {
            search(query: searchText)
        } else {
            //searchResult = []
        }
        tableView.reloadData()
    }
    
    var shouldUseSearchResult : Bool {
        /*
        if let searchText = searchController.searchBar.text {
            if searchText.isEmpty {
                return false
            }
        }
        return searchController.isActive
 */
        return true
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResult.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyTableViewCell
        
        // Configure the cell...
        /*
        let rect = CGRect(x: 0, y: 0, width: 200, height: 50)
        cell.column1 = UILabel(frame: rect)
        cell.column1.text = "Halloj"
        cell.backgroundView.addSubview(cell.column1)
        
        let rect2 = CGRect(x: 0, y: 200, width: 200, height: 50)
        cell.column2 = UILabel(frame: rect2)
        cell.column2.text = "Hej"
        cell.backgroundView.addSubview(cell.column2)
        */
        
        
        let (foodName, foodNumber) = searchResult[indexPath.row]
        cell.column1.text = foodName
        cell.foodQueryIndex = foodNumber
        if let calorieValue = calories[foodNumber] {
            cell.column2.text = "\(calorieValue) kcal"
        } else {
            cell.column2.text = "?"
        }
        
        //let calorie = calories[indexPath.row]
        //cell.column2.text = "\(calorie)"
        /*
        if shouldUseSearchResult {
            cell.textLabel?.text = searchResult[indexPath.row]
            //cell.foodQueryIndex = searchResult[indexPath.row]
            //cell.fruit är intern data, cell.textLabel.text det som visas i GUIt
        } else {
            cell.textLabel?.text = data[indexPath.row]
            //cell.foodQueryIndex = data[indexPath.row]
        }
         */
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if let cell = sender as? MyTableViewCell {
            if let vc = segue.destination as? NutritionViewController {
                if let actualfoodQueryIndex = cell.foodQueryIndex {
                    vc.foodQueryIndex = actualfoodQueryIndex
                }
            }
        }
        
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

}
