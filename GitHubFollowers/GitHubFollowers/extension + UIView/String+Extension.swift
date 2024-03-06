//
//  String+Extension.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 6.03.2024.
//

import Foundation

extension String {
    var asUrl: URL? {
        return URL(string: self)
    }
}
