//
//  CustomTextField.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 28/02/2023.
//

import Foundation
import UIKit

class CustomTextField: UITextField {
    
    let padding = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 0)
    
    override func awakeFromNib() {
        layer.borderWidth = 1
        layer.borderColor =  UIColor(named: Colors.shared.jet)?.cgColor
        clipsToBounds = true
        layer.cornerRadius = frame.size.height/4
        
    }
    
    override open func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func placeholderRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }

        override open func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.inset(by: padding)
        }
}
