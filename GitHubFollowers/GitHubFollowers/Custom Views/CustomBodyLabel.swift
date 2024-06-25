//
//  CustomBodyLabel.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 26.03.2024.
//

import UIKit

final class CustomBodyLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(textAlignment: NSTextAlignment, numberOfLines: Int) {
        super.init(frame: .zero)
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
        configure()
    }
    
    private func configure(){
        textColor = .secondaryLabel
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.75
        lineBreakMode = .byWordWrapping
        translatesAutoresizingMaskIntoContraints(false)
    }
    
}
