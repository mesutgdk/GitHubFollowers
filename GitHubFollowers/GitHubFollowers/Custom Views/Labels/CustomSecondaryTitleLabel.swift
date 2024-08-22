//
//  CustomSecondaryTitleLabel.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 22.08.2024.
//

import UIKit

final class CustomSecondaryTitleLabel: UILabel {

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(fontSize: CGFloat) {
        super.init(frame: .zero)
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .medium)
        configure()
    }
    
    private func configure(){
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.95
        lineBreakMode               = .byTruncatingTail
        translatesAutoresizingMaskIntoContraints(false)
    }
    

}
