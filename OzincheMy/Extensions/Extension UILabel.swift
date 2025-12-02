//
//  Extension UILabel.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 12.11.2025.
//

import UIKit

extension UILabel {
    
    func visibleLineCount() -> Int {
        
        guard let textToMeasure = (self.attributedText?.string ?? self.text), !textToMeasure.isEmpty else {
            return 0
        }

        let maxSize = CGSize(width: self.bounds.width, height: .greatestFiniteMagnitude)

        let textHeight: CGFloat
        var usedLineSpacing: CGFloat = 0

        if let attributed = self.attributedText, attributed.length > 0 {

            let rect = attributed.boundingRect(
                with: maxSize,
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
            )
            textHeight = ceil(rect.height)

            if let ps = attributed.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle {
                usedLineSpacing = ps.lineSpacing
            }
        } else {
            
            let attributes: [NSAttributedString.Key: Any] = [.font: self.font as Any]
            let rect = (textToMeasure as NSString).boundingRect(
                with: maxSize,
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                attributes: attributes,
                context: nil
            )
            textHeight = ceil(rect.height)
            usedLineSpacing = 0
        }

        let lineHeight = self.font.lineHeight + usedLineSpacing

        let lines = Int(ceil(textHeight / lineHeight))
        return lines
    }
}
