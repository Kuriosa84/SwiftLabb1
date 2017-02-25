//
//  DemoTableViewController.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-02-21.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import UIKit

class DemoTableViewController: UITableViewController, UISearchResultsUpdating {
    
    let data = ["Banana", "Orange", "Pineapple", "Mangostan", "Mango", "Kumquat", "Kiwi", "Apple", "Papple"]
    
    var searchResult : [String] = []
    
    var searchController : UISearchController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        definesPresentationContext = true

        searchController = UISearchController(searchResultsController:nil)
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text?.lowercased() {
            searchResult = data.filter({ item in item.lowercased().contains(searchText) })
        } else {
            searchResult = []
        }
        tableView.reloadData()
    }
    
    var shouldUseSearchResult : Bool {
        if let searchText = searchController.searchBar.text {
            if searchText.isEmpty {
                return false
            }
        }
        return searchController.isActive
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (shouldUseSearchResult ? searchResult.count : data.count)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MyTableViewCell

        // Configure the cell...
        
        if shouldUseSearchResult {
            cell.textLabel?.text = searchResult[indexPath.row]
            //cell.fruit = searchResult[indexPath.row]
            //cell.fruit är intern data, cell.textLabel.text det som visas i GUIt
        } else {
            cell.textLabel?.text = data[indexPath.row]
            //cell.fruit = data[indexPath.row]
        }
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
        
        //if let cell = sender as? MyTableViewCell {
            //segue.destination.title = cell.fruit
        //}
        
    }
    

}
