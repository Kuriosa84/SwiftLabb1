//
//  FavouritesTableViewController.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-02-25.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import UIKit

class FavouritesTableViewController: UITableViewController {
    
    let favouritesKey = "favourites"
    
    var favouriteIndexes : [Int] {
        get {
            let userDefaults = UserDefaults.standard
            if let actualFavourites = userDefaults.object(forKey: favouritesKey) as? [Int] {
                return actualFavourites
            } else {
                return []
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesCell", for: indexPath) as! MyTableViewCell
        
        let userDefaults = UserDefaults.standard
        let tupleArray = userDefaults.object(forKey: favouritesKey) as! [(Int, String, Int)]
        

        // Configure the cell...
        
        // Configure the cell...
        let foodNumber = tupleArray[indexPath.row].0
        cell.column1.text = tupleArray[indexPath.row].1
        cell.foodQueryIndex = foodNumber

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
        
        if let cell = sender as? MyTableViewCell {
            if let vc = segue.destination as? NutritionViewController {
                if let actualfoodQueryIndex = cell.foodQueryIndex {
                    vc.foodQueryIndex = actualfoodQueryIndex
                }
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
