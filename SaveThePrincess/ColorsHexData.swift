//
//  ColorsHexData.swift
//  SaveThePrincess
//
//  Created by Igor Angelov on 20/08/2017.
//  Copyright © 2017 Igor Angelov. All rights reserved.
//

import UIKit

extension UIColor {
    class func color(withData data:Data) -> UIColor {
        return NSKeyedUnarchiver.unarchiveObject(with: data) as! UIColor
    }
    
    func encode() -> Data {
        return NSKeyedArchiver.archivedData(withRootObject: self)
    }
}


/* Usage 
 var myColor = UIColor.green
 // Encoding the color to data
 let myColorData = myColor.encode() // This can be saved into coredata/UserDefaulrs
 let newColor = UIColor.color(withData: myColorData) // C
 */
