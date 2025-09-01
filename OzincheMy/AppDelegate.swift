//
//  AppDelegate.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 21.02.2025.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navBarAppearance = UINavigationBarAppearance()
        navBarAppearance.configureWithOpaqueBackground()
        navBarAppearance.backgroundColor = UIColor(named: "NavBarColor")
        navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(named: "TextColor") ?? .white]
           
           UINavigationBar.appearance().standardAppearance = navBarAppearance
           UINavigationBar.appearance().scrollEdgeAppearance = navBarAppearance
           UINavigationBar.appearance().compactAppearance = navBarAppearance
        
        let tabBarAppearance = UITabBarAppearance()
        // Создаём новый объект внешнего вида для TabBar — с ним мы задаём цвета и стили иконок/текста.

        tabBarAppearance.configureWithOpaqueBackground()
        // Устанавливаем непрозрачный фон таббара (убирает прозрачность, делает цвет чётким и предсказуемым).

        tabBarAppearance.backgroundColor = UIColor(named: "#FFFFFF-#1C2431") // вместо barTintColor
        // Задаём цвет фона таббара из ассетов по имени "TabBarColor" (ранее использовали .barTintColor, но он устарел).
        tabBarAppearance.stackedLayoutAppearance.selected.iconColor = UIColor(named: "7E2DFC")
        // Цвет иконки для выбранного (активного) таба.

        tabBarAppearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor(named: "TabBarSelectedIconColor") ?? .white]
//        // Цвет текста (названия) для активного таба. Используется тот же цвет, что и для иконки. Подстраховка на случай отсутствия цвета — .white.

        tabBarAppearance.stackedLayoutAppearance.normal.iconColor = UIColor(named: "#D1D5DB-#6B7280")
        // Цвет иконки для невыбранных (неактивных) табов.

//        tabBarAppearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor(named: "TabBarUnselectedIconColor") ?? .gray]
//        // Цвет текста (названия) для неактивных табов. Подстраховка — .gray, если цвет не найден.

        UITabBar.appearance().standardAppearance = tabBarAppearance
        // Устанавливаем этот внешний вид как стандартный для всех TabBar в обычном состоянии.

        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        // Очень важно для iOS 15+: устанавливаем внешний вид для ситуации, когда таббар находится у нижнего края прокручиваемого контента (например, скролл до низа). Без этой строки внешний вид может «сбрасываться».
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
}

