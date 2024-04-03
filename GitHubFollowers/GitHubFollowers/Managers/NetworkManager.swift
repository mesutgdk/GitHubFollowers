//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 3.04.2024.
//

import Foundation

final class NetworkManager{
    
    static let shared = NetworkManager()
    
    let baseURL = "https//api.github.com"
    
    private init() {}
    
    func getFollowers(for username: String, page: Int, comletion: @escaping ([Follower]?, String?)-> Void){
        let endpoint = baseURL + "/users/\(username)/followers?per_page=\(page)"
        
        guard let url = endpoint.asUrl else {
            comletion(nil, "This username created an invalid request. Please try again")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, responce, error in
            if let _ = error {
                comletion(nil, "Unable to complete your request. Please check your internet connection.")
            }
            
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                comletion(nil, "Invalid responce from the server. Please try again.")
                return
            }
            
            guard let data = data else {
                comletion(nil, "The data received from the server was invalid, Please try again.")
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let followers = try decoder.decode([Follower].self, from: data)
                
                comletion(followers, nil) // işlem başarılı, decode ettiğimizi yukarı atıyoruz
            } catch{
                comletion(nil, "The data received from the server was invalid, Please try again.")
            }
        
        }
        
        task.resume()
    }
}
