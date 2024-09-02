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
    
    func addCornerRadiusAndShadow(_ view: UIView, cornerRadius: CGFloat, borderWith:CGFloat, borderColor:UIColor, hasShadow:Bool){
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.masksToBounds = true
        
        view.layer.cornerRadius = cornerRadius
        view.clipsToBounds = true
        
        view.layer.borderWidth = borderWith
        view.layer.borderColor = borderColor.cgColor
        
        if hasShadow {
            view.layer.shadowColor = UIColor.black.cgColor
            view.layer.shadowOffset = CGSize(width: 3, height: 3)
            view.layer.shadowOpacity = 0.1
            view.layer.shadowRadius = 4
        }
    }
    
    // MARK: - Auto Layout Constraints
    @discardableResult
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                leading: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                trailing: NSLayoutXAxisAnchor? = nil,
                padding: UIEdgeInsets = .zero,
                size: CGSize = .zero) -> AnchoredConstraints {
        // Set translatesAutoresizingMaskIntoConstraints to false for auto layout
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchoredConstraints = AnchoredConstraints()
        
        // MARK: - Top Anchor
        if let top = top { anchoredConstraints.top = topAnchor.constraint(equalTo: top, constant: padding.top) }
        
        // MARK: - Leading Anchor
        if let leading = leading {anchoredConstraints.leading = leadingAnchor.constraint(equalTo: leading, constant: padding.left)}
        
        // MARK: - Bottom Anchor
        if let bottom = bottom {  anchoredConstraints.bottom = bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom) }
        
        // MARK: - Trailing Anchor
        if let trailing = trailing {anchoredConstraints.trailing = trailingAnchor.constraint(equalTo: trailing, constant: -padding.right)}
        
        // MARK: - Width Anchor
        if size.width != 0 { anchoredConstraints.width = widthAnchor.constraint(equalToConstant: size.width) }
        
        // MARK: - Height Anchor
        if size.height != 0 { anchoredConstraints.height = heightAnchor.constraint(equalToConstant: size.height) }
        
        // Activate constraints
        [anchoredConstraints.top, anchoredConstraints.leading, anchoredConstraints.bottom, anchoredConstraints.trailing, anchoredConstraints.width, anchoredConstraints.height].forEach { $0?.isActive = true }
        
        return anchoredConstraints
    }
    
    func fillSuperview(padding: UIEdgeInsets = .zero) {
        // Set translatesAutoresizingMaskIntoConstraints to false for auto layout
        translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Top Anchor
        if let superviewTopAnchor = superview?.topAnchor {
            topAnchor.constraint(equalTo: superviewTopAnchor, constant: padding.top).isActive = true
        }
        
        // MARK: - Bottom Anchor
        if let superviewBottomAnchor = superview?.bottomAnchor {
            bottomAnchor.constraint(equalTo: superviewBottomAnchor, constant: -padding.bottom).isActive = true
        }
        
        // MARK: - Leading Anchor
        if let superviewLeadingAnchor = superview?.leadingAnchor {
            leadingAnchor.constraint(equalTo: superviewLeadingAnchor, constant: padding.left).isActive = true
        }
        
        // MARK: - Trailing Anchor
        if let superviewTrailingAnchor = superview?.trailingAnchor {
            trailingAnchor.constraint(equalTo: superviewTrailingAnchor, constant: -padding.right).isActive = true
        }
    }
    
    func centerInSuperview(size: CGSize = .zero) {
        // Set translatesAutoresizingMaskIntoConstraints to false for auto layout
        translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Center X Anchor
        if let superviewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superviewCenterXAnchor).isActive = true
        }
        
        // MARK: - Center Y Anchor
        if let superviewCenterYAnchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: superviewCenterYAnchor).isActive = true
        }
        
        // MARK: - Width Anchor
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        
        // MARK: - Height Anchor
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
    }
    
    // MARK: - Center in Superview
    func centerXInSuperview() {
        // Set translatesAutoresizingMaskIntoConstraints to false for auto layout
        translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Center X Anchor
        if let superViewCenterXAnchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: superViewCenterXAnchor).isActive = true
        }
    }
    
    func centerYInSuperview() {
        // Set translatesAutoresizingMaskIntoConstraints to false for auto layout
        translatesAutoresizingMaskIntoConstraints = false
        
        // MARK: - Center Y Anchor
        if let centerY = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: centerY).isActive = true
        }
        
        func constrainWidth(constant: CGFloat) {
            // Set translatesAutoresizingMaskIntoConstraints to false for auto layout
            translatesAutoresizingMaskIntoConstraints = false
            
            // MARK: - Width Anchor
            widthAnchor.constraint(equalToConstant: constant).isActive = true
        }
        
        func constrainHeight(constant: CGFloat) {
            // Set translates to false for auto layout
            translatesAutoresizingMaskIntoConstraints = false
            
            // MARK: - Height Anchor
            heightAnchor.constraint(equalToConstant: constant).isActive = true
        }
    }
    
    /// A structure that holds Auto Layout constraints for anchoring views.
    struct AnchoredConstraints {
        var top, leading, bottom, trailing, width, height: NSLayoutConstraint?
    }
}

// UIEdgeInsets initinde değer verilmek istenmeyen parametrelerin default değeri 0 olarak ayarlandı.
extension UIEdgeInsets {
    init(top: CGFloat = .zero, leading: CGFloat = .zero, bottom: CGFloat = .zero, trailing: CGFloat = .zero) {
        self.init(top: top, left: leading, bottom: bottom, right: trailing)
    }
}

// CGSize initinde değer verilmek istenmeyen parametrelerin default değeri 0 olarak ayarlandı.
extension CGSize {
    init(widthSize: CGFloat = .zero, heightSize: CGFloat = .zero) {
        self.init(width: widthSize, height: heightSize)
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
