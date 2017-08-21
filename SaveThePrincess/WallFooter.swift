//
//  WallFooter.swift
//  SaveThePrincess
//
//  Created by Igor Angelov on 21/08/2017.
//  Copyright © 2017 Igor Angelov. All rights reserved.
//

import UIKit

class WallFooter: UICollectionReusableView {

    @IBOutlet weak var wall : UIImageView!
    @IBOutlet weak var princess : UIImageView!
    

    func  princessSaved(_ color:UIColor) {
        wall.image = UIImage(named: "WALL_OPEN")
        princess.image = UIImage(named: "PRINCESS_SAVED")
        princess.backgroundColor = color
    }
    
}
