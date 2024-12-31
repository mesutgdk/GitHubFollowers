//
//  CustomRepoItemVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 30.12.2024.
//

import UIKit

class CustomRepoItemVC: CustomItemInfoVC{
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func configureItem(){
        itemInfoViewOne.set(ItemInfoType: .repos, withCount: <#T##Int#>)
    }
}
