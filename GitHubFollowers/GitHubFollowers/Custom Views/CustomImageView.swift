//
//  CustomImageView.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 4.04.2024.
//

import UIKit

final class CustomImageView: UIImageView {

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
        image                                        = UIImage(named: "avatar-placeholder")
    }
    
}
