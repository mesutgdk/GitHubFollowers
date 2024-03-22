//
//  SceneDelegate.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 4.03.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        let tabVC = GFTabViewController()
        
        configureNavigationBar()
        
        window.rootViewController = tabVC
        window.makeKeyAndVisible()
        self.window = window
    }
    
    func configureNavigationBar(){
        UINavigationBar.appearance().tintColor = .systemGreen
        UINavigationBar.appearance().prefersLargeTitles = true
    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {}

    func sceneWillResignActive(_ scene: UIScene) {}

    func sceneWillEnterForeground(_ scene: UIScene) {}

    func sceneDidEnterBackground(_ scene: UIScene) {}


}

