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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true
        if let actualQuery = query {
            search(query: actualQuery)
        }
        
        
        //searchController = UISearchController(searchResultsController:nil)
        //searchController.searchResultsUpdater = self
        //searchController.dimsBackgroundDuringPresentation = false
        //tableView.tableHeaderView = searchController.searchBar
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func search(query : String) {
        //searchResult = []
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
                                for dictionary in parsed {
                                    if let foodName = dictionary["name"] as? String,
                                        let foodNumber = dictionary["number"] as? Int {
                                        
                                        self.searchResult.append((foodName,foodNumber))
                                        
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
        let (foodName, foodNumber) = searchResult[indexPath.row]
        cell.textLabel?.text = foodName
        cell.foodQueryIndex = foodNumber
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
