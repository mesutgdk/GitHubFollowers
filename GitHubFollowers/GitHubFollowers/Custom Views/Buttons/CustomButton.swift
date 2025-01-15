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
        configure()
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
    
    private func configure(){
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        
        setTitleColor(.white, for: .normal)
        translatesAutoresizingMaskIntoContraints(false)
        addCornerRadiusAndShadow(self, cornerRadius: 10, borderWith: 0, borderColor: .black, hasShadow: true)
    }
    
    func set(backgroundColor: UIColor, title: String){
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
}
