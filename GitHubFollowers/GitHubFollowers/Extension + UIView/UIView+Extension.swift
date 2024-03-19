//
//  extension+UIView.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 5.03.2024.
//

import UIKit

extension UIView{
    
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubview($0)
        })
    }
    
    /* Property */
    @discardableResult
    func translatesAutoresizingMaskIntoContraints(_ translate: Bool) -> Self {
        self.translatesAutoresizingMaskIntoConstraints = translate
        return self
    }
    
    func addShadowAndCornerRadius(_ view: UIView, cornerRadius: CGFloat, borderWith:CGFloat, borderColor:UIColor){
        view.layer.masksToBounds = true
        
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        
        view.layer.borderWidth = borderWith
        view.layer.borderColor = borderColor.cgColor
        
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 3, height: 3)
        view.layer.shadowOpacity = 0.1
        view.layer.shadowRadius = 4
    }
}

protocol UIViewContainer: AnyObject {
    var _view: UIView { get }

    func backgroundColor(_ color: UIColor) -> Self
    func isHidden(_ hidden: Bool) -> Self
    func clipsToBounds(_ clips: Bool) -> Self
    func alpha(_ alpha: CGFloat) -> Self
    func isUserInteractionEnabled(_ interactionEnabled: Bool) -> Self
    func contentMode(_ mode: UIView.ContentMode) -> Self
    func tintColor(_ color: UIColor) -> Self
    /* Diğer metodlar ... */
}

extension UIViewContainer {
    @discardableResult
    func backgroundColor(_ color: UIColor) -> Self {
        _view.backgroundColor = color
        return self
    }
    
    @discardableResult
    func isHidden(_ hidden: Bool) -> Self {
        _view.isHidden = hidden
        return self
    }
    
    @discardableResult
    func clipsToBounds(_ clips: Bool) -> Self {
        _view.clipsToBounds = clips
        return self
    }
    
    @discardableResult
    func alpha(_ alpha: CGFloat) -> Self {
        _view.alpha = alpha
        return self
    }
    
    @discardableResult
    func isUserInteractionEnabled(_ interactionEnabled: Bool) -> Self {
        _view.isUserInteractionEnabled = interactionEnabled
        return self
    }
    
    @discardableResult
    func contentMode(_ mode: UIView.ContentMode) -> Self {
        _view.contentMode = mode
        return self
    }
    
    @discardableResult
    func tintColor(_ color: UIColor) -> Self {
        _view.tintColor = color
        return self
    }
    
    /* Diğer metodlar ... */
}

extension UIDevice{
    static let isIphone = UIDevice.current.userInterfaceIdiom == .phone
}
