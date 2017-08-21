//
//  StringEntension.swift
//  SaveThePrincess
//
//  Created by Igor Angelov on 21/08/2017.
//  Copyright © 2017 Igor Angelov. All rights reserved.
//

import UIKit

extension String {
    func capitalizeFirst() -> String {
        if(self.characters.count>1) {
            let firstIndex = self.index(startIndex, offsetBy: 1)
            return self.substring(to: firstIndex).capitalized + self.substring(from: firstIndex).lowercased()
        }
        
        return self
    }
}
