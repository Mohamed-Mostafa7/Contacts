//
//  ShowPrifilePhotoViewController.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 22/03/2023.
//

import UIKit

class ShowPrifilePhotoViewController: UIViewController {
    
    var profileImage: UIImage?
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = profileImage
    }
    
}
