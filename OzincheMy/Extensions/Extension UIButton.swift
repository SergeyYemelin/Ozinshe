//
//  Extension UIButton.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 11.07.2025.
//

import Foundation
import UIKit

extension UIButton {
    func setLocalizedStyledTitle(_ key: String, lang: String, font: UIFont, color: UIColor) {
        let text = key.localized(lang: lang)
        let attrs: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: color]
        let attrString = NSAttributedString(string: text, attributes: attrs)
        
        self.setAttributedTitle(attrString, for: .normal)
        self.setAttributedTitle(attrString, for: .highlighted)
        self.setAttributedTitle(attrString, for: .selected)
    }
}
