//
//  CustomTextField.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 14.03.2024.
//

import UIKit

final class CustomTextField: UITextField {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoContraints(true)
        addShadowAndCornerRadius(self, cornerRadius: 10, borderWith: 2, borderColor: .systemGray4)
        
        textColor                   = .label
        tintColor                   = .label
        textAlignment               = .center
        font                        = UIFont.preferredFont(forTextStyle: .title2)
        adjustsFontSizeToFitWidth   = true
        minimumFontSize             = 12
        
        backgroundColor             = .tertiarySystemBackground
        autocorrectionType          = .no
        
        placeholder                 = "Enter an Username"
    }
}
