//
//  CustomLabel.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 23.03.2024.
//

import UIKit

final class CustomTitleLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        self.init(frame: .zero)
        self.textAlignment = textAlignment
        self.font = UIFont.systemFont(ofSize: fontSize, weight: .bold)
    }
    
    
    private func configure(){
        textColor = .label
//        font = UIFont.preferredFont(forTextStyle: .body)
//        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.9
        lineBreakMode = .byTruncatingTail
        translatesAutoresizingMaskIntoContraints(false)
    }
}
