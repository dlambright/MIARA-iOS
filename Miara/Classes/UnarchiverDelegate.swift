//
//  UnarchiverDelegate.swift
//  Miara
//
//  Created by Charlie Buckets on 1/12/17.
//  Copyright © 2017 ChalieBuckets. All rights reserved.
//

import UIKit

class UnarchiverDelegate: NSObject, NSKeyedUnarchiverDelegate {
    
    // This class is placeholder for unknown classes.
    // It will eventually be `nil` when decoded.
    final class Unknown: NSObject, NSCoding  {
        init?(coder aDecoder: NSCoder) { super.init(); return nil }
        func encode(with aCoder: NSCoder) {}
    }
    
    func unarchiver(_ unarchiver: NSKeyedUnarchiver, cannotDecodeObjectOfClassName name: String, originalClasses classNames: [String]) -> AnyClass? {
        return Unknown.self
    }
}


