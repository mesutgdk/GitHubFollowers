//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 3.04.2024.
//

import Foundation

final class NetworkManager{
    
    static let shared = NetworkManager()
    
    let baseURL = "https://api.github.com/users/"
    
    private init() {}
    
    
    func getFollowers(for username: String, page: Int, comletion: @escaping (Result<[Follower],AppError>)-> Void){
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = endpoint.asUrl else {
            comletion(.failure(.invalidUsername))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, responce, error in
            if let _ = error {
                comletion(.failure(.cantHandleRequest))
            }
            
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                comletion(.failure(.invalidResponce))
                return
            }
            
            guard let data = data else {
                comletion(.failure(.invalidData))
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let followers = try decoder.decode([Follower].self, from: data)
                
                comletion(.success(followers)) // işlem başarılı, decode ettiğimizi yukarı atıyoruz
            } catch{
                comletion(.failure(.decodingError))
            }
        
        }
        task.resume()
    }
    
    // MARK: - Old networkingway without result type
    // before swift 5, the old way with network, maybe it helps refactoring at some companies
    func getFollowersByOldWayWithoutResultType(for username: String, page: Int, comletion: @escaping ([Follower]?, ErrorMessage?)-> Void){
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)"
        
        guard let url = endpoint.asUrl else {
            comletion(nil, .invalidUsername)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, responce, error in
            if let _ = error {
                comletion(nil, .cantHandleRequest)
            }
            
            guard let responce = responce as? HTTPURLResponse, responce.statusCode == 200 else {
                comletion(nil, .invalidResponce)
                return
            }
            
            guard let data = data else {
                comletion(nil, .invalidData)
                return
            }
            do{
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let followers = try decoder.decode([Follower].self, from: data)
                
                comletion(followers, nil) // işlem başarılı, decode ettiğimizi yukarı atıyoruz
            } catch{
                comletion(nil, .decodingError)
            }
        
        }
        task.resume()
    }
}
