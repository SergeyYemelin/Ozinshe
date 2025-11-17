//
//  Extension UILabel.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 12.11.2025.
//

import UIKit

extension UILabel {
    /// Возвращает количество видимых строк в лейбле,
    /// учитывая attributedText (paragraphStyle.lineSpacing) если он есть.
    func visibleLineCount() -> Int {
        // если нет текста — 0
        guard let textToMeasure = (self.attributedText?.string ?? self.text), !textToMeasure.isEmpty else {
            return 0
        }

        // ширина, по которой будем измерять
        let maxSize = CGSize(width: self.bounds.width, height: .greatestFiniteMagnitude)

        // вычислим высоту текста правильно — если есть attributedText, используем его (он содержит paragraphStyle)
        let textHeight: CGFloat
        var usedLineSpacing: CGFloat = 0

        if let attributed = self.attributedText, attributed.length > 0 {
            // boundingRect для NSAttributedString
            let rect = attributed.boundingRect(
                with: maxSize,
                options: [.usesLineFragmentOrigin, .usesFontLeading],
                context: nil
            )
            textHeight = ceil(rect.height)

            // попробуем извлечь paragraphStyle из атрибутов (берём атрибуты первого символа)
            if let ps = attributed.attribute(.paragraphStyle, at: 0, effectiveRange: nil) as? NSParagraphStyle {
                usedLineSpacing = ps.lineSpacing
            }
        } else {
            // обычный текст без атрибутов
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

        // высота строки = font.lineHeight + lineSpacing (lineSpacing — именно то значение, которое добавляется к межстрочному расстоянию)
        let lineHeight = self.font.lineHeight + usedLineSpacing

        // делим и округляем вверх
        let lines = Int(ceil(textHeight / lineHeight))
        return lines
    }
}
