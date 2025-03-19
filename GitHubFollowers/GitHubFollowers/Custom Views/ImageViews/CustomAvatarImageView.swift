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
    
    
    func downloadImage(formURL url: String){
        NetworkManager.shared.downloadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
