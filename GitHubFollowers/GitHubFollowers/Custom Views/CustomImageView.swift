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
        contentMode                                  = .scaleAspectFill
        image                                        = UIImage(named: "avatar-placeholder")
    }
    
    func downloadImage(from urlString: String){
        guard let url = URL(string: urlString) else {return}
        
        let task = URLSession.shared.dataTask(with: url) { data, responce, error in
            if error != nil {return}
        }
    }
}
