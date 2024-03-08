//
//  GFTabViewController.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 8.03.2024.
//

import UIKit

final class GFTabViewController: UITabBarController{
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
    }
    
    private func setUpTabs() {
        
        setViewControllers([createSearchNavController(),createFavoriteNavController()], animated: true)

    }

    private func createSearchNavController() -> UINavigationController {
        let searchVC = SearchVC()
        searchVC.navigationItem.largeTitleDisplayMode = .automatic
        searchVC.title = "Search"
        
        let nav1 = UINavigationController(rootViewController: searchVC)
        nav1.navigationBar.prefersLargeTitles = true

        nav1.tabBarItem = UITabBarItem(title: "Search",
                                       image: UIImage(systemName: "magnifyingglass"),
                                       tag: 0)
        return nav1
    }
    
    private func createFavoriteNavController() -> UINavigationController {
        let favoriteVC = FavoriteListVC()
        favoriteVC.navigationItem.largeTitleDisplayMode = .automatic
        favoriteVC.title = "Favorite"
        
        let nav2 = UINavigationController(rootViewController: favoriteVC)
        nav2.navigationBar.prefersLargeTitles = true
        nav2.tabBarItem = UITabBarItem(title: "Favorite",
                                       image: UIImage(systemName: "star.fill"),
                                       tag: 1)
        
        return nav2
    }
}

