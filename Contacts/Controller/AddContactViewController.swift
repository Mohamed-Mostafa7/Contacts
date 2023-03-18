//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 14/03/2023.
//

import UIKit

class AddContactViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var contactDelegat: AddContactProtocol?
    
    @IBOutlet var contactImageView: UIImageView!
    @IBOutlet var contactFirstName: CustomTextField!
    @IBOutlet var contactLastName: CustomTextField!
    @IBOutlet var contactNumber: UITextField!
    var imageData: Data?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(addButtonTapped))
        
        // Add tap gesture recognizer to the picture.
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        contactImageView.isUserInteractionEnabled = true
        contactImageView.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    @objc func addButtonTapped(){
        contactDelegat?.contactInfo(
            firstName: contactFirstName.text ?? "",
            lastName: contactLastName.text ?? "",
            number: contactNumber.text ?? "",
            image: imageData
        )
        navigationController?.popViewController(animated: true)
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        _ = tapGestureRecognizer.view as! UIImageView
        // Use image picker to get the picture from library.
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    // MARK: - getting the Picture from the imagePicker.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else{ return }
        self.contactImageView.image = image
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FiltersCollectionViewController") as? FiltersCollectionViewController {
            vc.profileImage = image
            vc.selectedProfileImage = { image in
                self.contactImageView.image = image
                if let jpegData = image.jpegData(compressionQuality: 1.0) {
                    self.imageData = jpegData
                }
            }
            self.navigationController?.pushViewController(vc, animated: false)
            self.dismiss(animated: true)
        }
        
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
