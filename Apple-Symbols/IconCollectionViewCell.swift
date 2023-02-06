//
//  IconCollectionViewCell.swift
//  Apple-Symbols
//
//  Created by Caroline Davis on 9/1/2023.
//

import UIKit

class IconCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var iconView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setIcon(iconIndex: String, variableValue: Double) {
        let config = UIImage.SymbolConfiguration.preferringMulticolor()
        if #available(iOS 16.0, *) {
            iconView.image = UIImage(systemName: iconIndex, variableValue: variableValue, configuration: config)
        } else {
            iconView.image = UIImage(systemName: iconIndex, withConfiguration: config)
        }
    }

    // once its been clicked on its not 0.5 anymore, then its 1

}
