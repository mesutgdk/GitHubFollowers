//
//  UIHelper.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 24.05.2024.
//

import UIKit

struct UIHelper {
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout{
        
        let width                           = view.bounds.width
        let padding : CGFloat               = 12
        let minimumItemSpacing : CGFloat    = 10
        let availableWidht                  = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidht                       = availableWidht/3
        
        let flowLayout                          = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection              = .vertical
        flowLayout.sectionInset                 = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                     = CGSize(width: itemWidht, height: itemWidht + 40)
        
        return flowLayout
    }
  
}
