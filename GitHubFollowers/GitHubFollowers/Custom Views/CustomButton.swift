//
//  CustomButton.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 7.03.2024.
//

import UIKit

final class CustomButton: UIButton{
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(backgroundColor: UIColor, title: String) {
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    func configure(){
//        layer.cornerRadius      = 10
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoContraints(false)
        addShadowAndCornerRadius(self, cornerRadius: 10, borderWith: 0.0, borderColor: .black)
    }
}
