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

    func setIcon(iconIndex: String) {
        let config = UIImage.SymbolConfiguration.preferringMulticolor()
        iconView.image = UIImage(systemName: iconIndex, withConfiguration: config)
    }

}
