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
        view.layer.borderWidth = 0.5
        view.layer.borderColor =  UIColor(named: Colors.shared.jet)?.cgColor
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.3
        view.layer.shadowOffset = CGSize(width: 0.1, height: 0.1)
        view.layer.shadowRadius = 3
        
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
        if let imageData = model.image{
            personImageView.image = UIImage(data: imageData)
        } else {
            personImageView.image = UIImage(systemName: "person.circle.fill")
        }
        
        nameLabel.text = (model.firstName ?? "") + " " + (model.lastName ?? "")
        numberLabel.text = model.number
    }
    
}
