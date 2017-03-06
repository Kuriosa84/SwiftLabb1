//
//  Nutrients.swift
//  SwiftLabb1
//
//  Created by Asa Kwarnmark on 2017-03-02.
//  Copyright © 2017 Åsa Kwarnmark. All rights reserved.
//

import Foundation

class Nutrients {
    
    var name : String?
    let macroKeys, vitaminKeys, mineralKeys : [String]
    var macroValues, vitaminValues, mineralValues : [String : (String, Float?, String)]
    var healthValue : Float {
        get {
            let vitaminValue = vitaminValues.map({(key, value) in value.1}).flatMap({$0}).reduce(0, {$0 + $1})
            let mineralValue = mineralValues.map({(key, value) in value.1}).flatMap({$0}).reduce(0, {$0 + $1})
            var result = vitaminValue + mineralValue
            if let saturatedFat = macroValues["saturatedFattyAcids"]?.1 {
                result -= saturatedFat
            }
            return result
        }
    }
    
    init(name: String?) {
    
        self.name = name
        
        macroKeys = ["energyKcal", "protein", "fat", "saturatedFattyAcids",
                     "monounsaturatedFattyAcids", "sumPolyunsaturatedFattyAcids", "carbohydrates",
                     "fibres", "cholesterol"]
        
        macroValues = [
            macroKeys[0] : ("kCal", nil, ""),
            macroKeys[1] : ("Protein", nil, "g"),
            macroKeys[2] : ("Fett", nil, "g"),
            macroKeys[3] : ("Mättat fett", nil, "g"),
            macroKeys[4] : ("Enkelomättat fett", nil, "g"),
            macroKeys[5] : ("Fleromättat fett", nil, "g"),
            macroKeys[6] : ("Kolhydrater", nil, "g"),
            macroKeys[7] : ("Fibrer", nil, "g"),
            macroKeys[8] : ("Kolesterol", nil, "mg")
        ]

        vitaminKeys = ["retinolEquivalents", "thiamine", "riboflavin", "niacin", "folate", "vitaminB6", "vitaminB12", "vitaminC", "vitaminD", "vitaminE"]
        
        vitaminValues = [
            vitaminKeys[0] : ("A-vitamin", nil, "RE"),
            vitaminKeys[1] : ("Tiamin", nil, "mg"),
            vitaminKeys[2] : ("Riboflavin", nil, "mg"),
            vitaminKeys[3] : ("Niacin", nil, "mg"),
            vitaminKeys[4] : ("Folat", nil, "ug"),
            vitaminKeys[5] : ("Vitamin B6", nil, "mg"),
            vitaminKeys[6] : ("Vitamin B12", nil, "ug"),
            vitaminKeys[7] : ("C-vitamin", nil, "mg"),
            vitaminKeys[8] : ("D-vitamin", nil, "ug"),
            vitaminKeys[9] : ("E-vitamin", nil, "mg")
        ]
        
        mineralKeys = ["iron", "zink", "potassium", "selenium", "magnesium", "calcium"]
        
        mineralValues = [
            mineralKeys[0] : ("Järn", nil, "mg"),
            mineralKeys[1] : ("Zink", nil, "mg"),
            mineralKeys[2] : ("Kalium", nil, "mg"),
            mineralKeys[3] : ("Selen", nil, "ug"),
            mineralKeys[4] : ("Magnesium", nil, "mg"),
            mineralKeys[5] : ("Kalcium", nil, "mg")
        ]
        
    }
}
