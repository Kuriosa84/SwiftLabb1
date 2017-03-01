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
    
    let favouritesKey = "favourites"
    var foodQueryIndex : Int = 1
    var foodName = "banan"
    var calories = 0
    var iron : Float = 0
    var vitaminC : Float = 0
    var healthValue : Int = 0
    var nutritionKeys : [String] = []
    var vitaminKeys : [String] = []
    var mineralKeys : [String] = []
    var nutritionValues : [String : (String, Float?, String)] = [:]
    var vitaminValues : [String : (String, Float?, String)] = [:]
    var mineralValues : [String : (String, Float?, String)] = [:]
    
    var imagePath : String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory.appending("/\(foodQueryIndex).png")
    }
    
    var isInFavourites : Bool {
        get {
            let userDefaults = UserDefaults.standard
            if let favourites = userDefaults.object(forKey: favouritesKey) as? [Int] {
                return favourites.contains(foodQueryIndex)
            } else {
                return false
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nutritionKeys = ["energyKcal", "protein", "fat", "saturatedFattyAcids",
         "monounsaturatedFattyAcids", "sumPolyunsaturatedFattyAcids", "carbohydrates",
         "fibres", "cholesterol"]
        
        nutritionValues = [
            nutritionKeys[0] : ("kCal", nil, ""),
            nutritionKeys[1] : ("Protein", nil, "g"),
            nutritionKeys[2] : ("Fett", nil, "g"),
            nutritionKeys[3] : ("varav mättat fett", nil, "g"),
            nutritionKeys[4] : ("varav enkelomättat fett", nil, "g"),
            nutritionKeys[5] : ("varav fleromättat fett", nil, "g"),
            nutritionKeys[6] : ("Kolhydrater", nil, "g"),
            nutritionKeys[7] : ("Fibrer", nil, "g"),
            nutritionKeys[8] : ("Kolesterol", nil, "mg")
        ]
        
        if let image = UIImage(contentsOfFile: imagePath) {
            imageView.image = image
            NSLog("Image found.")
        } else {
            NSLog("No image was found.")
        }
        
        
        /*
        if(isInFavourites) {
            addToFavouritesButton.setTitle("Ta bort från favoriter", for: UIControlState.normal)
        }
        */
        search(query: foodQueryIndex)
        
        
        
        
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
    
    @IBAction func addToFavourites(_ sender: UIButton) {
        //let userDefaults = UserDefaults.standard
        
        
        
        //var myFavourites : [(Int, String, Int)]
        
        /*
        if(!isInFavourites) {
            if let favouritesArray = userDefaults.object(forKey: "favourites") as? [(Int, String, Int)] {
                myFavourites = favouritesArray
                myFavourites.append((foodQueryIndex, foodName, calories))
                userDefaults.set(myFavourites, forKey: "favourites")
            } else {
                myFavourites = []
                userDefaults.set(myFavourites, forKey:"favourites")
            }
            userDefaults.synchronize()
            sender.setTitle("Ta bort från favoriter", for: UIControlState.normal)
        } else {
            if let favouritesArray = userDefaults.object(forKey: "favourites") as? [(Int, String, Int)] {
                myFavourites = favouritesArray
                if let actualTupleIndex = getTupleIndex(tupleArray: myFavourites, foodIndex: foodQueryIndex) {
                    myFavourites.remove(at: actualTupleIndex)
                }
                userDefaults.set(myFavourites, forKey: favouritesKey)
            }
            sender.setTitle("Lägg till i favoriter", for: UIControlState.normal)
        }
         */
    }
    
    func getTupleIndex(tupleArray: [(Int, String, Int)], foodIndex: Int) -> (Int?) {
        for (i, tuple) in tupleArray.enumerated() {
            if tuple.0 == foodIndex {
                return i
            }
        }
        return nil
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
                            let name = parsed["name"] as? String {
                                DispatchQueue.main.async {
                                    self.nameLabel.text = name
                                    
                                    for key in self.nutritionKeys {
                                        if let value = nutrientValuesDictionary[key] as? Float {
                                            self.nutritionValues[key]?.1 = value
                                        } else {
                                            NSLog("Could not find nutrient \(key)")
                                        }
                                    }
                                    
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
    
    func getHealthValue(iron: Float, vitaminC: Float, kcal: Int) -> Int {
        return Int( iron * 20 + vitaminC * 2 + 80.0 / Float(kcal) )
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nutritionValues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NutritionCell", for: indexPath) as! MyTableViewCell
        
        let (nutrient, value, unit) = nutritionValues[nutritionKeys[indexPath.row]]!
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
