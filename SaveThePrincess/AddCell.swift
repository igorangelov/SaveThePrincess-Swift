//
//  AddCell.swift
//  SaveThePrincess
//
//  Created by Igor Angelov on 14/08/2017.
//  Copyright © 2017 Igor Angelov. All rights reserved.
//

import UIKit


protocol AddCellDelegate: class {
    func colorSelected(_ color: UIColor)
    func genreSelected(_ genre: String)
}

class AddCell: UITableViewCell {

    @IBOutlet weak var textField : UITextField!
    
    // Delegate is weak to avoid cycling retain
    weak var delegate:AddCellDelegate?
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

  
    
}
