//
//  FollowerCell.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 4.04.2024.
//

import UIKit

final class FollowerCell: UICollectionViewCell {
    static let cellIdentifier = String(describing: FollowerCell.self)
    
    let avatarImageView = CustomAvatarImageView(frame: .zero)
    let usernameLabel = CustomTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(follower: Follower){
        usernameLabel.text = follower.login
        
        NetworkManager.shared.downloadImage(from: follower.avatarUrl) { [weak self] image in
            guard let self                  = self else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }
    
    private func setup(){
        addSubviews(avatarImageView, usernameLabel)
    }
    
    private func layout(){
        let padding: CGFloat = 8
        
        // avatarImageView
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            avatarImageView.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
        ])
        
        // userNameLabel
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 12),
            usernameLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: padding),
            usernameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
