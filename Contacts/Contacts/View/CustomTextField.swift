//
//  CustomTextField.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 28/02/2023.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    override func awakeFromNib() {
        layer.borderWidth = 1
        layer.borderColor =  UIColor.lightGray.cgColor
        clipsToBounds = true
        layer.cornerRadius = frame.size.height/4
    }

}
