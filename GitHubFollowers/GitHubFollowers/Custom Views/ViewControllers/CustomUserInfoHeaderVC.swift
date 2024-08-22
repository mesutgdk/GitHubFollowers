//
//  CustomUserInfoHeaderVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 22.08.2024.
//

import UIKit

final class CustomUserInfoHeaderVC: UIViewController {

    let avatarImageView     = CustomImageView(frame: .zero)
    let usernameLabel       = CustomTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = CustomSecondaryTitleLabel(fontSize: 18)
    let locationImageView   = UIImageView()
    let locationLabel       = CustomSecondaryTitleLabel(fontSize: 18)
    let bioLabel            = CustomBodyLabel(textAlignment: .center, numberOfLines: 20)
    
    var user : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
