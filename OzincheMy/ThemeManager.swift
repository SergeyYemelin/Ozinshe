//
//  ThemeManager.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 21.07.2025.
//

import UIKit

enum AppTheme: String {
    case light, dark
}

final class ThemeManager {
    static let shared = ThemeManager()

    private let themeKey = "selectedTheme"

    private init() {}

    var currentTheme: AppTheme {
        get {
            let value = UserDefaults.standard.string(forKey: themeKey) ?? AppTheme.light.rawValue
            return AppTheme(rawValue: value) ?? .light
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: themeKey)
            updateInterfaceStyle()
        }
    }

    func applyStoredTheme() {
        updateInterfaceStyle()
    }

    private func updateInterfaceStyle() {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let windows = scene?.windows ?? []
        for window in windows {
            window.overrideUserInterfaceStyle = currentTheme == .dark ? .dark : .light
        }
        NotificationCenter.default.post(name: .themeChanged, object: nil)
    }
}

extension Notification.Name {
    static let themeChanged = Notification.Name("themeChanged")
}
