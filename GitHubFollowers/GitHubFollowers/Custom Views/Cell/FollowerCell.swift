//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 4.04.2024.
//

import UIKit

final class FollowerCell: UICollectionViewCell {
    static let cellIdentifier = String(describing: FollowerCell.self)
    
    let avatarImageView = CustomImageView(frame: .zero)
    let usernameLabel = CustomTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        
    }
    
    private func layout(){
        
    }
}
