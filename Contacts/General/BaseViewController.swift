//
//  BaseViewController.swift
//  Contacts
//
//  Created by Mohamed Mostafa on 30/05/2023.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        changeStatusBarColors()
    }
    
    func changeStatusBarColors() {
        let width = view.frame.size.width
        let height = view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 50
        let statusBarView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        statusBarView.backgroundColor = UIColor(named: Colors.shared.lightSeaGreen)
        view.addSubview(statusBarView)
        
    }
}
