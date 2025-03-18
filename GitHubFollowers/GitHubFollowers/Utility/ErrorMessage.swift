//
//  ErrorMessage.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 4.04.2024.
//

import Foundation

// used old type of errorHandling during network call
enum ErrorMessage: String {
    
    case invalidUsername
    case cantHandleRequest
    case invalidResponce
    case invalidData
    case decodingError
    
    var errorDescription: String {
        switch self {
        case .invalidUsername:
            return "This username created an invalid request. Please try again "
        case .cantHandleRequest:
            return "Unable to complete your request. Please check your internet connection. "
        case .invalidResponce:
            return "Invalid responce from the server. Please try again. "
        case .invalidData:
            return "The data received from the server was invalid, Please try again. "
        case .decodingError:
            return "The data can not be decoded, Please try again. "
        }
    }
}
