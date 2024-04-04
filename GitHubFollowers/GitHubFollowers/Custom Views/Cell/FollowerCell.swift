//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 4.04.2024.
//

import UIKit

final class FollowerCell: UICollectionViewCell {
    static let cellIdentifier = String(describing: FollowerCell.self)
    
    let avatarImageView = UIImageView()
    let usernameLabel = CustomTitleLabel(textAlignment: .center, fontSize: 16)
}
