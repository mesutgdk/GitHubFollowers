//
//  CustomUserInfoHeaderVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 22.08.2024.
//

import UIKit

final class AppUserInfoHeaderVC: UIViewController {
    
    let avatarImageView     = CustomAvatarImageView(frame: .zero)
    let usernameLabel       = CustomTitleLabel(textAlignment: .left, fontSize: 34)
    let nameLabel           = CustomSecondaryTitleLabel(fontSize: 18)
    let locationLabel       = CustomSecondaryTitleLabel(fontSize: 18)
    let bioLabel            = CustomBodyLabel(textAlignment: .center, numberOfLines: 20)
    let locationImageView   = {
        let locationImageView = UIImageView()
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        return locationImageView
    }()
    
    var user : User?
    
    init(user: User?) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        configureUIElements()
    }
    
    private func configureUIElements(){
        guard let user = user else {
            presentCustomAlertOnMainThread(title: "No User!", message: "Pls try it again.", buttonTitle: "Ok")
            return
        }
        
        downloadImage(user: user)
        
        usernameLabel.text              = user.login
        nameLabel.text                  = user.name ?? ""
        locationLabel.text              = user.location ?? "No Location"
        bioLabel.text                   = user.bio ?? "No bio available"
        bioLabel.numberOfLines          = 3
        locationImageView.image         = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor     = .secondaryLabel
    }
    
    private func downloadImage(user: User){
        NetworkManager.shared.downloadImage(from: user.avatarUrl) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }
    
    private func setup(){
        view.addSubviews(
            avatarImageView,
            usernameLabel,
            nameLabel,
            bioLabel,
            locationLabel,
            locationImageView
            
        )
    }
    
    private func layout(){
        let padding             :CGFloat        = 20
        let textImagePadding    :CGFloat        = 12
        
        // avatarImageView
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            avatarImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: padding),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90)
        ])
        
        // usernameLabel
        NSLayoutConstraint.activate([
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: textImagePadding),
            usernameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38)
        ])
        
        NSLayoutConstraint.activate([
            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor, constant: 8),
            nameLabel.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: textImagePadding),
            nameLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leftAnchor.constraint(equalTo: avatarImageView.rightAnchor, constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leftAnchor.constraint(equalTo: locationImageView.rightAnchor, constant: 5),
            locationLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: textImagePadding),
            bioLabel.leftAnchor.constraint(equalTo: avatarImageView.leftAnchor, constant: 5),
            bioLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
