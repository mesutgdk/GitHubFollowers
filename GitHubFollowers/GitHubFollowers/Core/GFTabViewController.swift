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
        let searchVC = SearchVC()
        let favoriteVC = FavoriteListVC()

        searchVC.navigationItem.largeTitleDisplayMode = .automatic
        favoriteVC.navigationItem.largeTitleDisplayMode = .automatic

        let nav1 = UINavigationController(rootViewController: searchVC)
        let nav2 = UINavigationController(rootViewController: favoriteVC)

        nav1.title = "Search"
        
        nav1.tabBarItem = UITabBarItem(title: "Search",
                                       image: UIImage(systemName: "magnifyingglass"),
                                       tag: 2)
        nav2.tabBarItem = UITabBarItem(title: "Favorite",
                                       image: UIImage(systemName: "star.fill"),
                                       tag: 3)
       
        for nav in [ nav1, nav2] {
            nav.navigationBar.prefersLargeTitles = true
        }

        setViewControllers(
            [nav1, nav2],
            animated: true
        )
    }
}

