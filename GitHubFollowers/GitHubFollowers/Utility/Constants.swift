//
//  Constants.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 11.09.2024.
//

import UIKit

enum SFSymbols {
    static let location         = UIImage(systemName: "mappin.and.ellipse")
    static let smile            = UIImage(systemName: "smile.fill")
    static let repos            = UIImage(systemName: "folder")
    static let gists            = UIImage(systemName: "text.alignleft")
    static let followers        = UIImage(systemName: "heart")
    static let following        = UIImage(systemName: "person.2")
    static let profile          = UIImage(systemName: "person.fill")
    static let searchBar        = UIImage(systemName: "magnifyingglass")
    static let favoriteBar      = UIImage(systemName: "star.fill")
    static let check            = "checkmark.circle"
    static let searchButton     = "person.2"
    static let profileButton    = "person"
}

enum Images{
    static let ghLogo           = UIImage(named: "gh-logo")
    static let placeholder      = UIImage(named: "avatar-placeholder")
    static let emtyStateLogo    = UIImage(named: "empty-state-logo")
}

enum ScreenSize {
    static let width            = UIScreen.main.bounds.size.width
    static let height           = UIScreen.main.bounds.size.height
    static let maxLength        = max(ScreenSize.width, ScreenSize.height)
    static let minLength        = min(ScreenSize.width, ScreenSize.height)
}

enum DeviceType {
    static let idiom            = UIDevice.current.userInterfaceIdiom
    static let nativeScale      = UIScreen.main.nativeScale
    static let scale            = UIScreen.main.scale
    
    static let isiPhoneSE                   = idiom == .phone && ScreenSize.maxLength == 568.0
    static let isiPhone8Standard            = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale == scale
    static let isiPhone8Zoomed              = idiom == .phone && ScreenSize.maxLength == 568.0 && nativeScale > scale
    static let isiPhone8PlusStandard        = idiom == .phone && ScreenSize.maxLength == 736.0
    static let isiPhone8PlusZoomed          = idiom == .phone && ScreenSize.maxLength == 667.0 && nativeScale > scale
    static let isiPhoneX                    = idiom == .phone && ScreenSize.maxLength == 812.0
    static let isiPhoneXsMaxAndXr           = idiom == .phone && ScreenSize.maxLength == 896.0
    static let isiPad                       = idiom == .pad && ScreenSize.maxLength == 1024.0
    
    static func isiPhoneXAspectRation() -> Bool {
        return isiPhoneX || isiPhoneXsMaxAndXr
    }
}
