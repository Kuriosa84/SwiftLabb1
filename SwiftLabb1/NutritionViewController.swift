//
//  NutritionViewController.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-02-25.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import UIKit

class NutritionViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var healthyLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var favouriteButton: UIButton!
    
    let favouritesKey = "favourites"
    var foodQueryIndex : Int = 1
    var foodName = "blabla"
    var healthValue : Int = 0
    var nutrients : Nutrients = Nutrients(name: nil)
    
    var imagePath : String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory.appending("/\(foodQueryIndex).png")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = UIImage(contentsOfFile: imagePath) {
            imageView.image = image
            NSLog("Image found.")
        } else {
            NSLog("No image was found.")
        }
        
        let fetcher = FetchValues(foodIndex: foodQueryIndex, tableView: tableView,
                                  nameLabel: nameLabel, healthyLabel: healthyLabel, graphView: nil)
        
        self.nutrients = fetcher.nutrients
        healthyLabel.text = "Nyttighet: \(nutrients.healthValue)"
        
        let fav = Favourites()
        if(fav.isInFavourites(index: foodQueryIndex)) {
            favouriteButton.setTitle("Ta bort från favoriter ⭐️", for: .normal)
        } else {
            favouriteButton.setTitle("Lägg till i favoriter ⭐️", for: .normal)
        }
    }
    
    @IBAction func takePhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        }
        else if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            picker.sourceType = .savedPhotosAlbum
        }
        present(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerEditedImage] as! UIImage
        
        if let data = UIImagePNGRepresentation(image) {
            do {
                let url = URL(fileURLWithPath: imagePath)
                try data.write(to: url)
                NSLog("Write successful: \(url)")
            } catch {
                NSLog("Write failed.")
            }
        }
        
        if let image = UIImage(contentsOfFile: imagePath) {
            imageView.image = image
            NSLog("Image found.")
        } else {
            NSLog("No image was found.")
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addOrRemoveFavourite(_ sender: UIButton) {
        let fav = Favourites()
        if(fav.isInFavourites(index: foodQueryIndex)) {
            fav.removeFavourite(foodIndex: foodQueryIndex)
            favouriteButton.setTitle("Lägg till i favoriter ⭐️", for: .normal)
        } else {
            fav.addFavourite(foodIndex: foodQueryIndex)
            favouriteButton.setTitle("Ta bort från favoriter ⭐️", for: .normal)
        }
    }

    
    func getTupleIndex(tupleArray: [(Int, String, Int)], foodIndex: Int) -> (Int?) {
        for (i, tuple) in tupleArray.enumerated() {
            if tuple.0 == foodIndex {
                return i
            }
        }
        return nil
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(section == 0) {
            return nutrients.macroKeys.count
        } else if(section == 1) {
            return nutrients.vitaminKeys.count
        } else {
            return nutrients.mineralKeys.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionCell", for: indexPath) as! MyTableViewCell
        
        var (nutrient, value, unit) : (String, Float?, String)
        
        if(indexPath.section == 0) {
            (nutrient, value, unit) = nutrients.macroValues[nutrients.macroKeys[indexPath.row]]!
        } else if(indexPath.section == 1) {
            (nutrient, value, unit) = nutrients.vitaminValues[nutrients.vitaminKeys[indexPath.row]]!
        } else {
            (nutrient, value, unit) = nutrients.mineralValues[nutrients.mineralKeys[indexPath.row]]!
            
        }
        
        cell.column1.text = nutrient
        
        if let actualValue = value {
            cell.column2.text = "\(actualValue) \(unit)"
        } else {
            cell.column2.text = "Loading..."
        }
        
        return cell
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
