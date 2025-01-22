//
//  CustomRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 30.12.2024.
//

import UIKit

class AppFollowerRepoItemVC: AppItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItem()
    }
    
    private func configureItem(){
        itemInfoViewOne.set(ItemInfoType: .repos, withCount: user.publicRepos)
        itemInfoViewTwo.set(ItemInfoType: .gists, withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "GitHub Profile")
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGitHubProfile(for: user)
    }
}
