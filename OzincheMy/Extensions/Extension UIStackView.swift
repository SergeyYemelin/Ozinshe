//
//  Extension UIStackView.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 30.06.2025.
//

import UIKit

extension UIStackView {
    
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
