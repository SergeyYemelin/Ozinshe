//
//  Extension Int.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 18.11.2025.
//

import Foundation

extension Int {
    func seasonText(for language: String) -> String {
        switch language {
        case "ru":
            if (11...14).contains(self % 100) { return "\(self) сезонов" }
            switch self % 10 {
            case 1: return "\(self) сезон"
            case 2,3,4: return "\(self) сезона"
            default: return "\(self) сезонов"
            }
        case "kk":
            return "\(self) маусым"
        case "en":
            return self == 1 ? "\(self) season" : "\(self) seasons"
        default:
            return "\(self) seasons"
        }
    }

    func episodeText(for language: String) -> String {
        switch language {
        case "ru":
            if (11...14).contains(self % 100) { return "\(self) серий" }
            switch self % 10 {
            case 1: return "\(self) серия"
            case 2,3,4: return "\(self) серии"
            default: return "\(self) серий"
            }
        case "kk":
            return "\(self) серия"
        case "en":
            return self == 1 ? "\(self) episode" : "\(self) episodes"
        default:
            return "\(self) episodes"
        }
    }
}
