//
//  FavoriteTVCell.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 30.01.2025.
//

import UIKit

class FavoriteTVCell: UITableViewCell {
    
    static let cellIdentifier   = String(describing: FavoriteTVCell.self)
    
    let avatarImageView         = CustomImageView(frame: .zero)
    let usernameLabel           = CustomTitleLabel(textAlignment: .center, fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addSubviews(avatarImageView, usernameLabel)
        
        accessoryType             = .disclosureIndicator
        
    }
    
    private func layout() {
        let padding:CGFloat       = 12
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalTo: avatarImageView.heightAnchor)
        ])
        
    }
    
}
