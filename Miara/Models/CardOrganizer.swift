//
//  CardOrganizer.swift
//  Miara1/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit
import SwiftSoup


class CardOrganizer: NSObject {
    
    var measurementArray = ["cup ", "cups ", " c ", " c. ",
                            "tablespoons", "tablespoon", "tbsp", "tbsp.", " tb ", " tb. ",
                                "teaspoons", "teaspoon", " tsp ", " tsp. ", " t ", " t. ",
                                "pinch", "slices", "slice", "to taste", "as needed", "or as needed"]
    
    
    func getDirectionsList(url: String, recipeIngredientsList: [String])->[String]{
        var recipeHtml : String!
        var listToReturn = [String]()
        var ingredientsList = recipeIngredientsList
        //make url request
        
        if let url = URL(string: url) {
            do {
                recipeHtml = try String(contentsOf: url)
                let doc: Document = try SwiftSoup.parse(recipeHtml)

                let links : Elements = try! doc.select("li")
            
                
                for element :Element in links.array() {
                    
                    if (ingredientsList.count > 0){
                        var remove = -1
                        for i in 0...ingredientsList.count-1{
                            if (try! element.text() == ingredientsList[i]){
                                remove = i
                            }
                        }
                        if (remove != -1){
                            print ("removing " + ingredientsList[remove])
                            ingredientsList.remove(at: remove)
                        }
                    }
                    else{
                        if (try! element.text() != ""){
                            print (try! element.text())
                            listToReturn.append(try! element.text())
                        }
                    }
                }
            } catch {
                // contents could not be loaded
            }
        } else {
            // the URL was bad!
        }
        return listToReturn
    }
    
    func matchesForRegexInText(regex: String, text: String) -> [String] {
        
        do {
            let regex = try NSRegularExpression(pattern: regex, options: [])
            let nsString = text as NSString
            let results = regex.matches(in: text,
                                                options: [], range: NSMakeRange(0, nsString.length))
            return results.map { nsString.substring(with: $0.range)}
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
    
    func stripIngredientsToBase(ingredientList : [String])->[String]{
        var newIngredientList = [String]()
        let numberPattern = "\\d+\\/?\\d?\\s?(\\(.*\\))?"
        let commaPattern = ",.*"
        
        // Take out numbers
        for ingredient in ingredientList{
            let matches = matchesForRegexInText(regex: numberPattern, text: ingredient)
            newIngredientList.append(ingredient.replacingOccurrences(of: matches[0], with: ""))
        }
        
        // Take out measurement words
        for i in 0...newIngredientList.count-1{
            for measurement in measurementArray{
                newIngredientList[i] = newIngredientList[i].replacingOccurrences(of: measurement, with: "")
            }
        }
        
        // Take out the stuff after a comma, if it exists
        for i in 0...newIngredientList.count-1{
            let matches = matchesForRegexInText(regex: commaPattern, text: newIngredientList[i])
            if (matches.count > 0){
                newIngredientList[i] = newIngredientList[i].replacingOccurrences(of: matches[0], with: "")
            }
        }
        return newIngredientList
    }
    
    func getCardDictionary(ingredientList: [String], instructionList: [String])->[CardData]{
        var simpleIngredientList = stripIngredientsToBase(ingredientList: ingredientList)
        var returnCardDataArray = [CardData]()
        var tokenizedIngredientList = [[String]]()
        var tokenizedInstructionList = [[String]]()
        
        for ingredient in simpleIngredientList{
            tokenizedIngredientList.append(createTokenizedWordList(newString: ingredient))
        }
        
        for instruction in instructionList{
            tokenizedInstructionList.append(createTokenizedWordList(newString: instruction))
        }
        
        var hitInstructionIndex = 0
        var hitInstructionWordIndex = 0
        var hitIngredientIndex = 0
        var hitIngredientWordIndex = 0
        var maxHits = 0
        var ingredientForInstructionFound = false
        
        for h in 0...tokenizedInstructionList.count-1{
            maxHits = 0
            ingredientForInstructionFound = false
            for i in 0...tokenizedInstructionList[h].count-1{
                
                for j in 0...tokenizedIngredientList.count-1{
                    
                    for k in 0...tokenizedIngredientList[j].count-1{
                        if (tokenizedInstructionList[h][i] == tokenizedIngredientList[j][k]){
                            var tempMaxHits = 0
                            var tempI = i
                            var tempK = k
                            while (tempI < tokenizedInstructionList[h].count &&
                                tempK < tokenizedIngredientList[j].count &&
                                tokenizedInstructionList[h][tempI] == tokenizedIngredientList[j][tempK]){
                                tempMaxHits = tempMaxHits + 1
                                if (tempMaxHits > maxHits){
                                    hitInstructionIndex = h
                                    hitIngredientIndex = j
                                    maxHits = tempMaxHits
                                }
                                tempI = tempI + 1
                                tempK = tempK + 1
                            }
                        }
                    }
                }
                if (maxHits > 0){
                    returnCardDataArray.append(CardData(newIngredient: ingredientList[hitIngredientIndex], newInstruction:instructionList[hitInstructionIndex]))
                    maxHits = 0
                    ingredientForInstructionFound = true
                }
                
            }
            if (maxHits == 0 && !ingredientForInstructionFound){
                returnCardDataArray.append(CardData(newIngredient: "", newInstruction:instructionList[h]))
            }
        }
        
        return returnCardDataArray
    }
    
    
    func createTokenizedWordList(newString : String)->[String]{
        var preProcessedString = newString.replacingOccurrences(of: "and ", with: "")
        preProcessedString = preProcessedString.lowercased()
        
        var toReturn = preProcessedString.components(separatedBy: " ")
        for i in 0...toReturn.count-1{
            toReturn[i] = toReturn[i].replacingOccurrences(of: ",", with: "")
            toReturn[i] = toReturn[i].replacingOccurrences(of: ".", with: "")
            toReturn[i] = toReturn[i].replacingOccurrences(of: "\"", with: "")
            toReturn[i] = toReturn[i].replacingOccurrences(of: ":", with: "")
        }
        return toReturn
    }


}
