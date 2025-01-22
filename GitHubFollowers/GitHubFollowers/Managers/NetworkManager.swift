//
//  NetworkManager.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 3.04.2024.
//

import UIKit

final class NetworkManager{
    
    static let shared   = NetworkManager()
    
    private let baseURL = "https://api.github.com/users/"
    
    let cache           = NSCache<NSString, UIImage>()
    
    private init() {}
    
    // network call for followers
    func getFollowers(for username: String, page: Int, comletion: @escaping (Result<[Follower],AppError>)-> Void){
        let endpoint = baseURL + "\(username)/followers?per_page=100&page=\(page)" // from developer.github.com
        
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
  
    // MARK: -
    
    func getUserInfo(for username: String, comletion: @escaping (Result<User,AppError>)-> Void){
        let endpoint = baseURL + "\(username)"
        
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
                
                let userInfo = try decoder.decode(User.self, from: data)
                
//                print(userInfo)
                
                comletion(.success(userInfo)) // işlem başarılı, decode ettiğimizi yukarı atıyoruz
            } catch{
                comletion(.failure(.decodingError))
            }
        }
        task.resume()
    }
    
    // MARK: - last version - async await
    
    func getUserInfoAsyncAwaitVersion(for username: String) async throws -> User {
        let endpoint = baseURL + "\(username)"
        
        // Ensure the endpoint URL is valid
        guard let url = endpoint.asUrl else {
            throw AppError.invalidUsername
        }
        
        do {
            // Perform the network request
            let (data, response) = try await URLSession.shared.data(from: url)
            
            // Validate HTTP response
            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw AppError.invalidResponce
            }
            
            // Decode the JSON response into the User model
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let userInfo = try decoder.decode(User.self, from: data)
            
            return userInfo
        } catch _ as DecodingError {
            throw AppError.decodingError
        } catch _ {
            throw AppError.cantHandleRequest
        }
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
