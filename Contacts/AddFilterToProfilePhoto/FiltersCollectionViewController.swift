//
//  CollectionViewController.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 17/03/2023.
//

import UIKit

class FiltersCollectionViewController: UICollectionViewController {
    
    var profileImage: UIImage? = UIImage(named: "Image2")
    var selectedProfileImage: ((_ imageBack: UIImage) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeStatusBarColors()
    }
    
    func changeStatusBarColors() {
        let width = view.frame.size.width
        let height = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 50
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        statusBarView.backgroundColor = #colorLiteral(red: 0.1303096116, green: 0.7275756001, blue: 0.6803478599, alpha: 1)
        view.addSubview(statusBarView)
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if let profileImage = profileImage {
                selectedProfileImage?(profileImage)
            }
        } else {
            guard let image = profileImage?.addFilter(filter: FilterType.allCases[indexPath.row - 1]) else {return}
            selectedProfileImage?(image)
        }
        navigationController?.popViewController(animated: true)
    }

    
    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 10
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCollectionViewCell", for: indexPath) as? ImageCollectionViewCell {
            if indexPath.row == 0 {
                guard let profileImage = profileImage else { return cell }
                cell.filteredImage.image = profileImage
                cell.filterNameLabel.text = "Original"
            } else {
                guard let profileImage = profileImage else { return cell }
                let filterIndex = indexPath.row - 1
                cell.filteredImage.image = profileImage.addFilter(filter: FilterType.allCases[filterIndex])
                cell.filterNameLabel.text = String(describing: FilterType.allCases[filterIndex])
            }
            return cell
        }
        return UICollectionViewCell()
    }
}

// MARK: - identifyint the frame of the collectionView Cell.
extension FiltersCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = 2
        let width = collectionView.frame.size.width
        let xInsets: CGFloat = 10
        let cellSpacing: CGFloat = 5
        
        return CGSize(width: (width/numberOfColumns) - (xInsets + cellSpacing + 20), height: (width/numberOfColumns) - (xInsets + cellSpacing + 20))
    }
}

// MARK: - Extend the UIImage to add filter.
extension UIImage {
    func addFilter(filter : FilterType) -> UIImage {
        let filter = CIFilter(name: filter.rawValue)
        // convert UIImage to CIImage and set as input
        let ciInput = CIImage(image: self)
        filter?.setValue(ciInput, forKey: "inputImage")
        // get output CIImage, render as CGImage first to retain proper UIImage scale
        let ciOutput = filter?.outputImage
        let ciContext = CIContext()
        let cgImage = ciContext.createCGImage(ciOutput!, from: (ciOutput?.extent)!)
        //Return the image
        return UIImage(cgImage: cgImage!)
    }
}

enum FilterType : String, CaseIterable {
    case Chrome = "CIPhotoEffectChrome"
    case Fade = "CIPhotoEffectFade"
    case Instant = "CIPhotoEffectInstant"
    case Mono = "CIPhotoEffectMono"
    case Noir = "CIPhotoEffectNoir"
    case Process = "CIPhotoEffectProcess"
    case Tonal = "CIPhotoEffectTonal"
    case Transfer =  "CIPhotoEffectTransfer"
    case Sepia = "CISepiaTone"
    
}
