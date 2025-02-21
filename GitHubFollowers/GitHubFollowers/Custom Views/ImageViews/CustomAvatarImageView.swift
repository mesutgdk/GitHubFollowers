//
//  CustomImageView.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 4.04.2024.
//

import UIKit

final class CustomAvatarImageView: UIImageView {
    
    let placeHolderImage = Images.placeholder
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints    = false
        layer.cornerRadius                           = 10
        clipsToBounds                                = true
        contentMode                                  = .scaleAspectFill
        image                                        = placeHolderImage
    }
}
