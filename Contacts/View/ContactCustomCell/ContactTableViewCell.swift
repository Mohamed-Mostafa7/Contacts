//
//  ContactTableViewCell.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 28/02/2023.
//

import UIKit

class ContactTableViewCell: UITableViewCell {

    @IBOutlet var view: UIView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var numberLabel: UILabel!
    @IBOutlet var personImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.shadowColor = UIColor.gray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        view.layer.shadowRadius = 5
        
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
        personImageView.layer.cornerRadius = personImageView.frame.size.height / 2
        personImageView.clipsToBounds = true
        
        nameLabel.text = (model.firstName ?? "") + " " + (model.lastName ?? "")
        numberLabel.text = model.number
    }
    
}
