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
    
    convenience init(backgroundColor: UIColor, title: String, systemImageName: String) {
        self.init(frame: .zero)
        set(backgroundColor: backgroundColor, title: title, systemImageName: systemImageName)
        //        configure()   //    we call self.init, it calls configure, no need to recall
    }
    
    private func configure(){
        

        configuration                = .tinted()
        configuration?.cornerStyle  = .large
        translatesAutoresizingMaskIntoContraints(false)
        //        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        //        setTitleColor(.white, for: .normal)
        //        addCornerRadiusAndShadow(self, cornerRadius: 10, borderWith: 0, borderColor: .black, hasShadow: true)
    }
    
    final func set(backgroundColor: UIColor, title: String, systemImageName: String){
        configuration?.baseBackgroundColor    = backgroundColor
        configuration?.baseForegroundColor    = backgroundColor
        
        configuration?.title            = title
        configuration?.image            = UIImage(systemName: systemImageName)
        configuration?.imagePadding     = 6
        configuration?.imagePlacement   = .leading
        
        //        setTitle(title, for: .normal)
        //        setImage(UIImage(systemName: systemImageName), for: .normal)

    }
}
