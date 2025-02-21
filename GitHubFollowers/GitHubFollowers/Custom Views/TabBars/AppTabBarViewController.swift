//
//  GFTabViewController.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 8.03.2024.
//

import UIKit

final class AppTabBarViewController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        tabBar.backgroundColor = .systemBackground
        UITabBar.appearance().tintColor = .systemGreen
        
        setViewControllers([createSearchNavController(),createFavoriteNavController()], animated: true)

    }

    private func createSearchNavController() -> UINavigationController {
        let searchVC = SearchVC()

        searchVC.title = "Search"
        
        let nav1 = UINavigationController(rootViewController: searchVC)
        
        nav1.tabBarItem = UITabBarItem(title: "Search",
                                       image: Images.searchBar,
                                       tag: 0)
        return nav1
    }
    
    private func createFavoriteNavController() -> UINavigationController {
        let favoriteVC = FavoriteListVC()
        favoriteVC.title = "Favorite"
        
        let nav2 = UINavigationController(rootViewController: favoriteVC)
        nav2.tabBarItem = UITabBarItem(title: "Favorite",
                                       image: Images.favoriteBar,
                                       tag: 1)
        
        return nav2
    }
}

