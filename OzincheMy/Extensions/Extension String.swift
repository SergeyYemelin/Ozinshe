//
//  Extension String.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 27.06.2025.
//

import Foundation

extension String {
    func localized(lang: String) -> String {
        guard let path = Bundle.main.path(forResource: lang, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return self
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: "")
    }
}
