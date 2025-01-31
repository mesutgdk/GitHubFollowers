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
    
    func configure(favorite: Follower){
        usernameLabel.text = favorite.login
        avatarImageView.downloadImage(from: favorite.avatarUrl)
    }
    
    private func setup() {
        addSubviews(avatarImageView, usernameLabel)
        
        accessoryType                   = .disclosureIndicator
        
    }
    
    private func layout() {
        let padding:CGFloat             = 12
        let avatarSqureSide:CGFloat     = 60
        let usernameHeight:CGFloat      = 40
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: avatarSqureSide),
            avatarImageView.widthAnchor.constraint(equalToConstant: avatarSqureSide)
        ])
        
        NSLayoutConstraint.activate([
            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: padding*2),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: usernameHeight)
            
        ])
        
    }
    
}
