//
//  AppError.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 4.04.2024.
//

import Foundation

enum AppError: LocalizedError {
    case invalidUsername
    case cantHandleRequest
    case invalidResponce
    case invalidData
    case decodingError
    case unableToFavorite
    
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
        case .unableToFavorite:
            return "There was a problem favoriting the user. Please try again."
        }
    }
}
