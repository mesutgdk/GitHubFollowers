//
//  CustomEmtyStateView.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 5.07.2024.
//

import UIKit

final class CustomEmtyStateView: UIView {

    
    let messageLabel = CustomBodyLabel(textAlignment: .center, numberOfLines: 28)
    let logoImageView = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setup(){
        addSubviews(messageLabel,logoImageView)
    }
    
    private func layout(){
        
    }
    
}
