//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 21.03.2024.
//

import UIKit

class FollowerListVC: UIViewController {

    var userName : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    private func layout(){
        NetworkManager.shared.getFollowers(for: userName, page: 1) { (followers, errorMessage) in
            guard let followers = followers else {
                self.presentCustomAlertOnMainThread(title: "Something bad happened", message: errorMessage!, buttonTitle: "Ok")
                return
            }
            print("Followers.count = \(followers.count)")
            print(followers)
        }
    }

}
