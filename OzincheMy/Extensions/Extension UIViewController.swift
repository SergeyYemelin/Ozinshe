//
//  Extension UIViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 28.06.2025.
//

import UIKit

extension UIViewController {
    
    func setupBackArrow() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "BackArrow"), for: .normal)
        backButton.tintColor = UIColor(named: "111827-FFFFFF")
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        backButton.addTarget(self, action: #selector(backArrowTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    
    func setupWhiteBackArrow() {
        let backButton = UIButton(type: .custom)
        backButton.setImage(UIImage(named: "BackArrow"), for: .normal)
        backButton.tintColor = UIColor(named: "FFFFFF")
        backButton.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        backButton.addTarget(self, action: #selector(backArrowTapped), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }

    @objc func backArrowTapped() {
        navigationController?.popViewController(animated: true)
    }
}
