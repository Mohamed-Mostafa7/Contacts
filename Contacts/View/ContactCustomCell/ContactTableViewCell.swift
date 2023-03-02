//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 28/02/2023.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static let identifier = "ContactTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ContactTableViewCell", bundle: nil)
    }
    
    func configure(model: Contact) {
        nameLabel.text = (model.firstName ?? "") + " " + (model.lastName ?? "")
        numberLabel.text = model.number
    }
    
}
