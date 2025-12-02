//
//  Extension UIViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 28.06.2025.
//

import UIKit

extension UIViewController {
    
    enum BackArrowStyle {
        case white
        case black
    }
    
//    func setupBackArrow() {
//        let backButton = UIButton(type: .custom)
//        backButton.setImage(UIImage(named: "BackArrow"), for: .normal)
//        backButton.tintColor = UIColor(named: "111827-FFFFFF")
//        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
//        backButton.addTarget(self, action: #selector(backArrowTapped), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
//    }
    
    func setupBackArrow(style: BackArrowStyle) {
        let backButton = UIButton(type: .custom)
        
        let imageName: String
        let tint: UIColor?
        
        switch style {
        case .white:
            imageName = "BackArrowBlack"
            tint = UIColor(named: "FFFFFF")
        case .black:
            imageName = "BackArrowBlack"
            tint = UIColor(named: "111827-FFFFFF")
        }
        
        backButton.setImage(UIImage(named: imageName), for: .normal)
        backButton.tintColor = tint
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        backButton.addTarget(self, action: #selector(backArrowTapped), for: .touchUpInside)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    @objc func backArrowTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func presentSimpleAlert(title: String, message: String) {
            let alert = UIAlertController(
                title: title,
                message: message,
                preferredStyle: .alert
            )
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
    }
}
