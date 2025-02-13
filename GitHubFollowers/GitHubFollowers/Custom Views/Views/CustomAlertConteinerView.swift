//
//  CustomAlertConteinerView.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 13.02.2025.
//

import UIKit

final class CustomAlertConteinerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        backgroundColor = .systemBackground
        addCornerRadiusAndShadow(self,
                                 cornerRadius: 16,
                                 borderWith: 2,
                                 borderColor: .white,
                                 hasShadow: false)
    }
}
