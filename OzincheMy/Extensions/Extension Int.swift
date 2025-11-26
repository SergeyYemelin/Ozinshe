//
//  Extension Int.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 18.11.2025.
//

extension Int {
    func declension(_ one: String, _ few: String, _ many: String) -> String {
        let n = self
        let mod10 = n % 10
        let mod100 = n % 100

        if mod100 >= 11 && mod100 <= 14 {
            return "\(n) \(many)"
        } else if mod10 == 1 {
            return "\(n) \(one)"
        } else if mod10 >= 2 && mod10 <= 4 {
            return "\(n) \(few)"
        } else {
            return "\(n) \(many)"
        }
    }
}
