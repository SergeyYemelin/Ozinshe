//
//  TabBarViewController.swift
//  OzincheMy
//
//  Created by Сергей Емелин on 21.02.2025.
//

import UIKit

@available(iOS 17.0, *)
class TabBarViewController: UITabBarController {

    private var appearanceObserver: UITraitChangeRegistration?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.backgroundColor = UIColor(named: "FFFFFF-1C2431")
        
        SetupTabs()
        
        appearanceObserver = registerForTraitChanges(
                    [UITraitUserInterfaceStyle.self]
                ) { (self: Self, previousTraitCollection: UITraitCollection) in
                    self.updateTabBarIcons()
                }
    }
    
    func SetupTabs() {
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let favoriteVC = FavoriteViewController()
        let profileVC = ProfileViewController()
        let homeNav = UINavigationController(rootViewController: homeVC)
        let profileNav = UINavigationController(rootViewController: profileVC)
        let searchNav = UINavigationController(rootViewController: searchVC)
        let favoriteNav = UINavigationController(rootViewController: favoriteVC)
        
        homeVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Home"), selectedImage: UIImage(named: "HomeSelected"))
        
        searchVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Search"), selectedImage: UIImage(named: "SearchSelected"))
        favoriteVC.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Favorite"), selectedImage: UIImage(named: "FavoriteSelected"))
        profileNav.tabBarItem = UITabBarItem(title: "", image: UIImage(named: "Profile"), selectedImage: UIImage(named: "ProfileSelected"))
        
//        setViewControllers( [homeVC, searchVC, favoriteVC, profileVC], animated: true)
        viewControllers = [homeNav, searchNav, favoriteNav, profileNav]
    }
    
    private func updateTabBarIcons() {
            guard let items = tabBar.items else { return }

            if items.indices.contains(0) {
                items[0].image = UIImage(named: "Home")
                items[0].selectedImage = UIImage(named: "HomeSelected")
            }
        
            if items.indices.contains(1) {
                items[1].image = UIImage(named: "Search")
                items[1].selectedImage = UIImage(named: "SearchSelected")
            }
        
            if items.indices.contains(0) {
            items[2].image = UIImage(named: "Favorite")
            items[2].selectedImage = UIImage(named: "FavoriteSelected")
            }
        
            if items.indices.contains(1) {
            items[3].image = UIImage(named: "Profile")
            items[3].selectedImage = UIImage(named: "ProfileSelected")
            }
        }
}

