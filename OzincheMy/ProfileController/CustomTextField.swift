//
//  CustomTextField.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 27.05.2025.
//

import UIKit

class CustomTextField: UITextField {
    
    var textPadding = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: textPadding)
    }
    
}
