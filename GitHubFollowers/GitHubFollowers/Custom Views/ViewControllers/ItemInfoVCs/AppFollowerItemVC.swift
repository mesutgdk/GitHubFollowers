//
//  CustomFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 6.01.2025.
//

import UIKit

class AppFollowerItemVC: AppFollowerItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem(){
        itemInfoViewOne.set(ItemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(ItemInfoType: .following , withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers")
    }
}

