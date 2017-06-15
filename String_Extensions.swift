//
//  String_Extensions.swift
//  Miara
//
//  Created by Charlie Buckets on 6/15/17.
//  Copyright © 2017 ChalieBuckets. All rights reserved.
//

// Happily borrowed from https://gist.github.com/albertbori/0faf7de867d96eb83591

import Swift
import UIKit

extension String
{
    init(htmlEncodedString: String) {
        self.init()
        guard let encodedData = htmlEncodedString.data(using: .utf8) else {
            self = htmlEncodedString
            return
        }
        
        let attributedOptions: [String : Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            self = attributedString.string
        } catch {
            print("Error: \(error)")
            self = htmlEncodedString
        }
    }
    
    func fixHtmlEncoding(htmlEncodedString: String) -> String{
        guard let encodedData = htmlEncodedString.data(using: .utf8) else {
            return htmlEncodedString
        }
        
        
        let attributedOptions: [String : Any] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: String.Encoding.utf8.rawValue
        ]
        
        do {
            let attributedString = try NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
            return attributedString.string
        } catch {
            print("Error: \(error)")
            return htmlEncodedString
        }
    }
}
