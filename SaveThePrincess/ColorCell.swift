//
//  ColorCell.swift
//  SaveThePrincess
//
//  Created by Igor Angelov on 21/08/2017.
//  Copyright © 2017 Igor Angelov. All rights reserved.
//

import UIKit
import ColorSlider

class ColorCell: UITableViewCell {

    @IBOutlet weak var colorDisplay : UIView!
    @IBOutlet weak var colorSelection : UIView!
    
    // Delegate is weak to avoid cycling retain
    weak var delegate:AddCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        colorDisplay.backgroundColor = UIColor.gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // MARK: - ColorSlider
    
    func setColor () {
        let colorSlider = ColorSlider()
        colorSlider.frame = CGRect(x: 0,y: 0,width: self.colorSelection.frame.size.width,height:self.colorSelection.frame.size.height)
        colorSlider.previewEnabled = true
        colorSlider.orientation = .horizontal
        colorSlider.addTarget(self, action: #selector(self.changedColor(_:)), for: .valueChanged)
        colorSelection.addSubview(colorSlider)
    }
    
    func changedColor(_ slider: ColorSlider) {
        self.colorDisplay.backgroundColor = slider.color
        self.delegate?.colorSelected(slider.color)
    }

}
