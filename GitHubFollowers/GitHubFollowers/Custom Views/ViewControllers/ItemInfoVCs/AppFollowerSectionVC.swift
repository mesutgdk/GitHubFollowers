//
//  CustomFollowerItemVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 6.01.2025.
//

import UIKit

protocol AppFollowerSectionVCDelegate:AnyObject{
    func didTapGetFollowers(for user : User)
}

class AppFollowerSectionVC: AppItemInfoVC{
    
    weak var delegate: AppFollowerSectionVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem(){
        itemInfoViewOne.set(ItemInfoType: .followers, withCount: user.followers)
        itemInfoViewTwo.set(ItemInfoType: .following , withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "Get Followers", systemImageName: SFSymbols.searchButton)
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGetFollowers(for: user)
    }
}

