//
//  CustomEmtyStateView.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 5.07.2024.
//

import UIKit

final class CustomEmtyStateView: UIView {

    let messageLabel     = CustomBodyLabel(textAlignment: .center, numberOfLines: 3)
    let logoImageView    = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "empty-state-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
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
        
        messageLabel.font = .systemFont(ofSize: 22)
        messageLabel.textColor      = .secondaryLabel
        
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
//            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            logoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 200),
            logoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 40)
            
        ])
    }
    
}
