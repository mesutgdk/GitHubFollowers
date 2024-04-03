//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 3.04.2024.
//

import Foundation

final class NetworkManager{
    let shared = NetworkManager()
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, comlition: @escaping ([Follower]?, String?)-> Void){
        
    }
}
