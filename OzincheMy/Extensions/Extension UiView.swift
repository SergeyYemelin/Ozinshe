//
//  Extension UiView.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 01.05.2025.
//


import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        views.forEach { addSubview($0) }
    }
}

