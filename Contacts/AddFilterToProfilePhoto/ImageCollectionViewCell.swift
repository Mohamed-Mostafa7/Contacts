//
//  ImageCollectionViewCell.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 17/03/2023.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var filteredImage: UIImageView!
    
    @IBOutlet var filterNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    func configure(){
        layer.borderWidth = 1
        layer.borderColor =  UIColor(named: Colors.shared.jet)?.cgColor
        clipsToBounds = true
        layer.cornerRadius = 20
    }
}
