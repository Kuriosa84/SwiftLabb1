//
//  FavouritesTableViewController.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-02-25.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import UIKit

class FavouritesTableViewController: UITableViewController {
    
    let favouritesObject = Favourites()
    //var favourites : [(index: Int, name: String, calories: Float)?]?
    public static var nrOfSelections : Int = 0
    var selectedFoodIndex1 : Int = 1
    var selectedFoodIndex2 : Int = 2
    var selectedFoodName1 : String = "Citron"
    var selectedFoodName2 : String = "Banan"
    
    
    @IBOutlet weak var compareButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        favouritesObject.fetchFavourites(tableView: self.tableView)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

    }
    
    public func enableCompareButton() {
        compareButton.setTitle("Jämför livsmedel", for: .normal)
        compareButton.isEnabled = true
    }
    
    public func disableCompareButton() {
        compareButton.setTitle("Välj två livsmedel att jämföra", for: .normal)
        compareButton.isEnabled = false
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favouritesObject.favourites.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> MyTableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavouritesCell", for: indexPath) as! MyTableViewCell
        
        cell.viewController = self
        
        if let favourite = favouritesObject.favourites[indexPath.row] {
            cell.column1.text = favourite.name
            cell.column2.text = "\(favourite.calories) kCal"
            cell.foodQueryIndex = favourite.index
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
        
        if let cell = sender as? MyTableViewCell {
            if let vc = segue.destination as? NutritionViewController {
                if let actualfoodQueryIndex = cell.foodQueryIndex {
                    vc.foodQueryIndex = actualfoodQueryIndex
                }
            }
        }
        
        if segue.identifier == "CompareSegue" {
            if let vc = segue.destination as? DiagramViewController {
                vc.foodIndex1 = selectedFoodIndex1
                vc.foodIndex2 = selectedFoodIndex2
                vc.foodName1 = selectedFoodName1
                vc.foodName2 = selectedFoodName2
            }
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
