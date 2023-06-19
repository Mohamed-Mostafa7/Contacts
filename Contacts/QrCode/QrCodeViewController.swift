//
//  QrCodeViewController.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 19/06/2023.
//

import UIKit

class QrCodeViewController: BaseViewController {
    
    
    @IBOutlet weak var QrCodeImageView: UIImageView!
    
    var firstName: String?
    var lastName: String?
    var number: String?
    var image: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "arrowshape.turn.up.forward.fill"), style: .plain, target: self, action: #selector(shareContact))
        let image = generateQRCode(from: getStringFromContact())
        QrCodeImageView.image = image
    }
    
    @objc func shareContact() {
        let text = getStringFromContact()
        let image = image
        let shareAll = [text , image!] as [Any]
        let activityViewController = UIActivityViewController(activityItems: shareAll, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    func getStringFromContact() -> String {
        let string = "First name: \(firstName ?? "") \nLast name: \(lastName ?? "") \nNumber: \(number ?? "") "
        return string
    }
    
    func generateQRCode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CIQRCodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }

}
