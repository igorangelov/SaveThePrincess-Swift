//
//  SoldierCollectionViewCell.swift
//  SaveThePrincess
//
//  Created by Igor Angelov on 17/08/2017.
//  Copyright © 2017 Igor Angelov. All rights reserved.
//

import UIKit

protocol SoldierCellDelegate: class {
    func soldierAttack(_ soldier:Soldier)

}

class SoldierCell: UICollectionViewCell {
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var image : UIImageView!
    @IBOutlet weak var button : UIButton!
    
    // Delegate is weak to avoid cycling retain
    weak var delegate:SoldierCellDelegate?
    
    var soldier: Soldier?{
        didSet {
            // Update the view.
            setCell()
        }
    }

    func setCell() {
        
        let firstCharacter =  "\((soldier?.gender?.characters.first)!)"
        
        self.name.text =  "\((soldier?.name?.capitalizeFirst())!) - " + "\(firstCharacter.capitalized) - "  + "\((soldier?.age)!)y"
        //change soldier color - default grey color
        if let data = soldier?.color {
            let newColor = UIColor.color(withData: data as Data)
            self.image.backgroundColor = newColor
        }
        //button style
        self.button.layer.cornerRadius = 5
        self.button.layer.borderColor = UIColor.lightGray.cgColor
        self.button.layer.borderWidth = 1
        
        //action
        self.button.addTarget(self, action: #selector(self.attackAction(_:)), for: .touchUpInside)
    }
    
    func attackAction(_ button: UIButton) {
        self.delegate?.soldierAttack(soldier!)
    }
}
