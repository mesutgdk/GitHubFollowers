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
        
        
    }
    
}
