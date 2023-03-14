//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 14/03/2023.
//

import UIKit

class AddContactViewController: UIViewController {
    
    var contactDelegat: AddContactProtocol?
    
    @IBOutlet var contactImageView: UIImageView!
    @IBOutlet var contactFirstName: CustomTextField!
    @IBOutlet var contactLastName: CustomTextField!
    
    @IBOutlet var contactNumber: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
        
    }
    
    
    @objc func addButtonTapped(){
        contactDelegat?.contactInfo(
            firstName: contactFirstName.text ?? "",
            lastName: contactLastName.text ?? "",
            number: contactNumber.text ?? ""
        )
        navigationController?.popViewController(animated: true)
    }

}

// MARK: - custmaizing view UI
extension AddContactViewController {
    // Changing the NavigationBarTitle to small
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewDidLayoutSubviews() {
        customImageView(contactImageView)
    }
    
    func customImageView (_ imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.size.width/2
        imageView.layer.borderWidth = 5
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.clipsToBounds = true
    }
}
