//
//  GenreCell.swift
//  SaveThePrincess
//
//  Created by Igor Angelov on 21/08/2017.
//  Copyright © 2017 Igor Angelov. All rights reserved.
//

import UIKit

class GenreCell: UITableViewCell{

    @IBOutlet weak var control : UISegmentedControl!
    
    // Delegate is weak to avoid cycling retain
    weak var delegate:AddCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        control.addTarget(self, action: #selector(self.valueChange(_:)), for: .valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func valueChange(_ control:UISegmentedControl) {
        if control.selectedSegmentIndex == 0 {
            self.delegate?.genreSelected(Gender.male)
        }
        
        if control.selectedSegmentIndex == 1 {
            self.delegate?.genreSelected(Gender.female)
        }
        
        if control.selectedSegmentIndex == 2 {
            self.delegate?.genreSelected(Gender.other)
        }
        
    }
}
