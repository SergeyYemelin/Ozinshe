
//
//  PaddedTextField.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 09.06.2025.
//

import UIKit

class PaddedTextField: UITextField {

    var padding = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
}
