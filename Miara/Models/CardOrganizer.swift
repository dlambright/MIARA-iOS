//
//  CardOrganizer.swift
//  Miara1/16.
//  Copyright © 2016 ChalieBuckets. All rights reserved.
//

import UIKit
import SwiftSoup
import Foundation


class CardOrganizer: NSObject {
    
    var listTypeArray = ["ul", "ol"]
    
    var measurementArray = ["cup ", "cups ", " c. ", " c ",
                            "tablespoons", "tablespoon", "tbsp.", "tbsp", " tb. ", " tb ",
                            "teaspoons", "teaspoon", " tsp. ", " tsp ", " t. ", " t ",
                            "ounces", "ounce", " oz. ", " oz ",
                            "large ", "lg ", "lg.",
                            " cans ", " can ", "packages ", "package ", "packets ", "packet ",
                            "pinch ", "slices ", "slice ", "to taste", "as needed", "or as needed",
                                
                            "Cup ", "Cups ", " C ", " C. ",
                            "Tablespoons", "Tablespoon", "Tbsp.", "Tbsp", " Tb. ", " Tb ",
                            "Teaspoons", "Teaspoon", " Tsp. ", " Tsp ", " T. ", " T ",
                            "Ounces", "Ounce", " Oz. ", " Oz ",
                            "Large ", "Lg ", "Lg.",
                            " Cans ", " Can ", "Packages ", "Package ", "Packets ", "Packet ",
                            "pinch ", "slices ", "slice ", "to taste", "as needed", "or as needed"]
    
    var adjectives = ["shredded"]
    
    
    func getDirectionsList(url: String, recipeIngredientsList: [String])->[String]{
        var recipeHtml : String!
        var listToReturn = [String]()
        //make url request
        
        
        if let url = URL(string: url) {
            do {
                recipeHtml = try String(contentsOf: url)
                let doc: Document = try SwiftSoup.parse(recipeHtml)
                
                
                listToReturn = findInstructionsInList(doc: doc)
                
                if (listToReturn.count == 0){
                    listToReturn = findInstructionsInDivsWithParagraphs(doc: doc)
                }
                
                if (listToReturn.count == 0){
                    listToReturn = findInstructionsInDivsWithBreaks(doc: doc)
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
        let numberOrPattern = "\\d [Oo][Rr] \\d "
        let numberToPattern = "\\d [Tt][Oo] \\d "
        let commaPattern = ",.*"
        
        
        // Take out numbers
        for ingredient in ingredientList{
            var tempIngredient = ingredient
            
            var matches = matchesForRegexInText(regex: numberOrPattern, text: tempIngredient)
            if (matches.count > 0){
                tempIngredient = ingredient.replacingOccurrences(of: matches[0], with: "")
                newIngredientList.append(tempIngredient)
                continue
            }
            
            matches = matchesForRegexInText(regex: numberToPattern, text: tempIngredient)
            if (matches.count > 0){
                tempIngredient = ingredient.replacingOccurrences(of: matches[0], with: "")
                newIngredientList.append(tempIngredient)
                continue
            }
            
            matches = matchesForRegexInText(regex: numberPattern, text: tempIngredient)
            if (matches.count > 0){
                tempIngredient = ingredient.replacingOccurrences(of: matches[0], with: "")
                newIngredientList.append(tempIngredient)
            }
            else if (tempIngredient.characters.last != ":"){ // : bullshit dividers
                newIngredientList.append(tempIngredient)
            }
        }
        
        // Take out measurement words
        if newIngredientList.count > 0{
            for i in 0...newIngredientList.count-1{
                for measurement in measurementArray{
                    newIngredientList[i] = newIngredientList[i].replacingOccurrences(of: measurement, with: "")
                }
            }
            
            // Take out the stuff after a comma, if it exists
            for i in 0...newIngredientList.count-1{
                // This chicken breast stuff has come up twice now in tow tries....
                if (newIngredientList[i].lowercased().range(of:"chicken breast") != nil){
                    newIngredientList[i] = "chicken breast"
                    break
                }
                let matches = matchesForRegexInText(regex: commaPattern, text: newIngredientList[i])
                if (matches.count > 0){
                    newIngredientList[i] = newIngredientList[i].replacingOccurrences(of: matches[0], with: "")
                }
            }
        }
        return newIngredientList
    }
    
    func getCardDictionary(ingredientList: [String], instructionURL: String)->[CardData]{
        
        var instructionList = getDirectionsList(url: instructionURL, recipeIngredientsList: ingredientList)
        
        
        let simpleIngredientList = stripIngredientsToBase(ingredientList: ingredientList)
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
        var hitIngredientIndex = 0
        var maxHits = 0
        var ingredientForInstructionFound = false
        
        if tokenizedInstructionList.count > 0{
            for h in 0...tokenizedInstructionList.count-1{
                maxHits = 0
                ingredientForInstructionFound = false
                let wordIndexArray = getIndicesOfWordsIn(theString: instructionList[h])
                var i = 0
                var lowWord = i
                var highWord = 0
                
                while i < tokenizedInstructionList[h].count{
                //for i in 0...tokenizedInstructionList[h].count-1{
                    
                    for j in 0...tokenizedIngredientList.count-1{
                        
                        for k in 0...tokenizedIngredientList[j].count-1{
                            if (tokenizedInstructionList[h][i] == tokenizedIngredientList[j][k]){
                                var tempMaxHits = 0
                                var tempI = i
                                var tempK = k
                                
                                while (lowWord < tokenizedInstructionList[h].count &&
                                    tempK < tokenizedIngredientList[j].count &&
                                    tokenizedInstructionList[h][tempI] == tokenizedIngredientList[j][tempK] &&
                                    !self.wordIsFillerWord(word: tokenizedInstructionList[h][tempI])){
                                        tempMaxHits = tempMaxHits + 1
                                        if (tempMaxHits > maxHits){
                                            hitInstructionIndex = h
                                            hitIngredientIndex = j
                                            maxHits = tempMaxHits
                                            lowWord = i
                                            highWord = tempI
                                        }
                                        tempI = tempI + 1
                                        tempK = tempK + 1
                                        highWord = tempI
                                        if (tempI > tokenizedInstructionList[h].count-1){
                                        break
                                    }
                                }
                            }
                        }
                    }
                    if (maxHits > 0){
                        let tempCardData = CardData(newIngredient: ingredientList[hitIngredientIndex], newInstruction: instructionList[hitInstructionIndex], newRangeLow: wordIndexArray[i], newRangeHigh: wordIndexArray[lowWord + 1])
                        
                        if (tempCardData.ingredient != returnCardDataArray.last?.ingredient ||
                            tempCardData.instruction != returnCardDataArray.last?.instruction){
                            returnCardDataArray.append(CardData(newIngredient: ingredientList[hitIngredientIndex], newInstruction:instructionList[hitInstructionIndex], newRangeLow: wordIndexArray[i], newRangeHigh: wordIndexArray[highWord]))
                            i = i + (maxHits-1) // advance the marker the number of hits to avoid any possible repeats
                        }
                        maxHits = 0
                        ingredientForInstructionFound = true
                    }
                    i = i + 1
                }
                if (maxHits == 0 && !ingredientForInstructionFound){
                    if (instructionList[h] != ""){
                        returnCardDataArray.append(CardData(newIngredient: "", newInstruction:instructionList[h], newRangeLow: 0, newRangeHigh: 0))
                    }
                }
                lowWord = 0
                highWord = 0
                
            }
        }
        
        return returnCardDataArray
    }
    
    func wordIsFillerWord(word: String)->Bool{
        let fillerWords = ["and", "with", "or", "are", "of", "for"]
        for fillerWord in fillerWords{
            if word.lowercased() == fillerWord.lowercased(){
                return true
            }
        }
        return false
    }
    
    
    func createTokenizedWordList(newString : String)->[String]{
        //var preProcessedString = newString.replacingOccurrences(of: "and ", with: "")
        var preProcessedString = newString.lowercased()
        
        preProcessedString = preProcessedString.trimmingCharacters(in: .whitespaces)
        var toReturn = preProcessedString.components(separatedBy: " ")
        for i in 0...toReturn.count-1{
            toReturn[i] = toReturn[i].replacingOccurrences(of: ",", with: "")
            toReturn[i] = toReturn[i].replacingOccurrences(of: ".", with: "")
            toReturn[i] = toReturn[i].replacingOccurrences(of: "\"", with: "")
            toReturn[i] = toReturn[i].replacingOccurrences(of: ":", with: "")
            toReturn[i] = toReturn[i].replacingOccurrences(of: "/", with: " ")
            toReturn[i] = toReturn[i].replacingOccurrences(of: "\\", with: " ")
            toReturn[i] = toReturn[i].trimmingCharacters(in: .whitespaces)
        }
        return toReturn
    }
    
    private func findInstructionsInDivsWithBreaks(doc: Document)->[String]{
        var listItems = [String]()
        let links : Elements = try! doc.select("div")
        
        for element : Element in links.array() {
            
            //print (try! element.attr("class"))
            let classString = try! element.attr("class")
            
            if (classString.lowercased().range(of:"panel-collapse collapse in") != nil ||
                classString.lowercased().range(of:"instructions") != nil){
                
                if (try! element.attr("id").lowercased().range(of:"instruction") != nil){
                    let tempString = try! element.html()
                    
                    let tempArray = tempString.components(separatedBy: "<br>")
                    
                    for item in tempArray{
                    let tempItem = item.replacingOccurrences(of: "\n", with: "")
                        
                    let matches = matchesForRegexInText(regex: "<.*?>", text: tempItem)
                        
                        if (matches.count > 0){
                            listItems.append(tempItem.replacingOccurrences(of: matches[0], with: ""))
                        }
                        else{
                            if (tempItem != "" && tempItem != " "){
                                listItems.append(tempItem)
                            }

                        }
                    }
                }
            }
        }
        return listItems
    }
    
    private func findInstructionsInDivsWithParagraphs(doc: Document)->[String]{
        var listItems = [String]()
        let links : Elements = try! doc.select("div")
        
        for element : Element in links.array() {
            
            //print (try! element.attr("class"))
            let classString = try! element.attr("class")
            
            if (classString.lowercased().range(of:"instruction") != nil){
                
                let tempString = try! element.html()
                
                let tempArray = tempString.components(separatedBy: "<p>")
                
                for item in tempArray{
                    var tempItem = item.replacingOccurrences(of: "\n", with: "")
                    
                    let matches = matchesForRegexInText(regex: "<.*?>", text: tempItem)
                    
                    if (matches.count > 0){
                        for i in 0...matches.count-1{
                            tempItem = tempItem.replacingOccurrences(of: matches[i], with: "")
                        }
                        
                        if ( tempItem != ""){
                            listItems.append(tempItem)
                        }
                        
                        
                    }
                    else{
                        if (tempItem != "" && tempItem != " "){
                            listItems.append(tempItem)
                        }
                        
                    }
                }
                
            }
        }
        return listItems
    }
    
    private func findInstructionsInList(doc: Document)->[String]{
        var listToReturn = [String]()
        var listItems = Elements()
        for listType in listTypeArray{
            let links : Elements = try! doc.select(listType)
            
            for element :Element in links.array() {
                
                //print (try! element.attr("class"))
                let classString = try! element.attr("class")
                
                if (classString.lowercased().range(of:"directions") != nil ||
                    classString.lowercased().range(of:"instructions") != nil ||
                    classString.lowercased().range(of:"preparation") != nil){
                    
                    listItems = try! element.select("li")
                    
                    break
                }
            }
        }
        
        if (listItems.array().count == 0){
            let links : Elements = try! doc.select("div")
            
            for element :Element in links.array() {
                
                //print (try! element.attr("class"))
                let classString = try! element.attr("class")
                if (classString.lowercased().range(of:"directions") != nil ||
                    classString.lowercased().range(of:"instructions") != nil){
                    
                    listItems = try! element.select("li")
                    break
                }
                
                /*
                 
                 if (classString.lowercased().range(of:"directions") != nil ||
                 classString.lowercased().range(of:"instructions") != nil){
                 
                 listItems = try! element.select("li")
                 break
                 }*/
            }
        }
        
        for element :Element in listItems.array() {
            if (try! element.text() != ""){
                //print (try! element.text())
                listToReturn.append(try! element.text())
            }
            
        }
        
        return listToReturn
    }
    

    func getIndicesOfWordsIn(theString: String)->[Int]{
        var wordStartIndicesArray = [Int]()
        //wordStartIndicesArray.append(0)
        //var candidateString = theString.replacingOccurrences(of: "and ", with: "")
        var candidateString = theString.trimmingCharacters(in: .whitespaces)
        candidateString = " "  + candidateString
        
        // prime the loop
        var spaceLoc = candidateString.characters.index(of : " ")
        var pos = candidateString.characters.distance(from: candidateString.startIndex, to: spaceLoc!)
        wordStartIndicesArray.append(pos)
        var index = candidateString.index(candidateString.startIndex, offsetBy: pos + 1)
        candidateString = candidateString.substring(from:index)
        
        spaceLoc = candidateString.characters.index(of : " ")
        if (spaceLoc != nil){
            pos = candidateString.characters.distance(from: candidateString.startIndex, to: spaceLoc!)
            wordStartIndicesArray.append(wordStartIndicesArray.last! + pos)
            index = candidateString.index(candidateString.startIndex, offsetBy: pos + 1)
            candidateString = candidateString.substring(from:index)
            spaceLoc = candidateString.characters.index(of : " ")
            
            while (spaceLoc != nil){
                pos = candidateString.characters.distance(from: candidateString.startIndex, to: spaceLoc!)
                
                wordStartIndicesArray.append(wordStartIndicesArray.last! + pos + 1)
                
                index = candidateString.index(candidateString.startIndex, offsetBy: pos + 1)
                candidateString = candidateString.substring(from:index)
                
                spaceLoc = candidateString.characters.index(of : " ")
                
            }
            
            wordStartIndicesArray.append(wordStartIndicesArray.last! + candidateString.characters.count)
        }

        
        
        return wordStartIndicesArray
        
    }

}
