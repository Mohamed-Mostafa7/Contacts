//
//  AddContactViewController.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 14/03/2023.
//

import UIKit

class AddContactViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    private lazy var gallery = UIAction(title: "Gallery", image: UIImage(systemName: "photo.stack")) { [weak self] (action) in
        self?.openGallery()
     }

    private lazy var camera = UIAction(title: "Camera", image: UIImage(systemName: "camera.fill")) { [weak self] (action) in
        self?.openCamera()
     }
    
    private lazy var showImage = UIAction(title: "Show image", image: UIImage(systemName: "photo.fill")) { [weak self] (action) in
        self?.showProfileImage()
    }
    
    var menu = UIMenu()
    let picker = UIImagePickerController()
     
    @IBOutlet var hiddenButton: UIButton!
    var contactDelegat: AddContactProtocol?
    
    @IBOutlet var contactImageView: UIImageView!
    @IBOutlet var contactFirstName: CustomTextField!
    @IBOutlet var contactLastName: CustomTextField!
    @IBOutlet var contactNumber: UITextField!
    var imageData: Data?
    var contact: Contact?
    var updatedContactClosure: ((Contact) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactFirstName.text = contact?.firstName
        contactLastName.text = contact?.lastName
        contactNumber.text = contact?.number
        if let data = contact?.image {
            contactImageView.image = UIImage(data: data)
        }
        
        picker.delegate = self
        // add menu to the prifile image to choose the gallery or the camera.
        menu = UIMenu(title: "Pick an image", options: .displayInline, children: [gallery , camera, showImage])
        hiddenButton.menu = menu
        hiddenButton.showsMenuAsPrimaryAction = true
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(saveButtonTapped))
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    // MARK: - save the coantact
    @objc func saveButtonTapped(){
        contact?.firstName = contactFirstName.text
        contact?.lastName = contactLastName.text
        contact?.number = contactNumber.text
        contact?.fullName = ("\(contact?.firstName ?? "") \(contact?.lastName ?? "")")
        contactDelegat?.contactInfo(
            firstName: contactFirstName.text ?? "",
            lastName: contactLastName.text ?? "",
            number: contactNumber.text ?? "",
            image: imageData
        )
        updatedContactClosure?(contact!)
        navigationController?.popViewController(animated: true)
    }
    // MARK: - Using ImagePicker to get image from Gallery.
    func showProfileImage() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "ShowPrifilePhotoViewController") as? ShowProfilePhotoViewController {
            if imageData == nil && contact?.image == nil{
                let alertController = alert(message: "No profile photo added for this contact!")
                present(alertController, animated: true)
            }else {
                vc.profileImage = contactImageView.image
                navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    func openGallery() {
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    // MARK: - Using ImagePicker to get image from Camera.
    func openCamera(){
            if(UIImagePickerController .isSourceTypeAvailable(.camera)){
                picker.sourceType = .camera
                picker.allowsEditing = true
                present(picker, animated: true, completion: nil)
            } else {
                let alertController = alert(message: "No Camera support for this device")
                present(alertController, animated: true)
            }
        }
    
    func alert(message: String) -> UIAlertController {
        let controller = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default)
        controller.addAction(action)
        return controller
    }
    
    
    // MARK: - After getting the Picture from the imagePicker we send it to filters viewController.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else{ return }
        self.contactImageView.image = image
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FiltersCollectionViewController") as? FiltersCollectionViewController {
            vc.profileImage = image
            vc.selectedProfileImage = { image in
                self.contactImageView.image = image
                if let jpegData = image.jpegData(compressionQuality: 1.0) {
                    self.imageData = jpegData
                    self.contact?.image = jpegData
                }
            }
            self.navigationController?.pushViewController(vc, animated: false)
            self.dismiss(animated: true)
        }
    }
}

// MARK: - custmaizing view UI Appearance
extension AddContactViewController {
    // Changing the NavigationBarTitle to small
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.prefersLargeTitles = false
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
