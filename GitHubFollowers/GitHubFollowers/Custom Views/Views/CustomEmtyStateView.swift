//
//  CustomEmtyStateView.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 5.07.2024.
//

import UIKit

final class CustomEmtyStateView: UIView {

    let messageLabel     = CustomBodyLabel(textAlignment: .center, numberOfLines: 28)
    let logoImageView    = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(message: String){
        super.init(frame: .zero)
        messageLabel.text   = message
        setup()
        layout()
    }
    
    
    private func setup(){
        addSubviews(messageLabel,logoImageView)
        
        messageLabel.numberOfLines  = 3
        messageLabel.textColor      = .secondaryLabel
        
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout(){
        
        NSLayoutConstraint.activate([
            messageLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -150),
            messageLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 40),
            messageLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            logoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1.3),
            logoImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 200),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 140)
            
        ])
    }
    
}
