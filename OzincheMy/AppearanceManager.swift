////
////  Untitled.swift
////  OzincheMy
////
////  Created by Сергей Емелин on 04.07.2025.
////
//import UIKit
//
//enum AppearanceManager {
//    
//    static func configureGlobalAppearance() {
//        configureNavigationBar()
//        configureTabBar()
//    }
//    
//    private static func configureNavigationBar() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor(named: "NavBarColor")
//        appearance.titleTextAttributes = [.foregroundColor: UIColor(named: "TextColor") ?? .black]
//        
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().compactAppearance = appearance
//    }
//    
//    private static func configureTabBar() {
//        let appearance = UITabBarAppearance()
//        appearance.configureWithOpaqueBackground()
//        appearance.backgroundColor = UIColor(named: "")
//        
//        appearance.stackedLayoutAppearance.normal.iconColor = UIColor(named: "TabInactiveColor")
//        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "AccentColor")
//        
//        UITabBar.appearance().standardAppearance = appearance
//        UITabBar.appearance().scrollEdgeAppearance = appearance
//        UITabBar.appearance().tintColor = UIColor(named: "AccentColor") // цвет активной иконки
//    }
//}
