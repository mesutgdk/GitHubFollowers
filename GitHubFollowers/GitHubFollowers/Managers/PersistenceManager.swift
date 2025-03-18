//
//  PersistenceManager.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 23.01.2025.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys{
        static let favorites = "favorites"
    }
    
    static func updateWith(favorite: Follower,
                           actionType: PersistenceActionType,
                           completed: @escaping(AppError?)-> Void) {
        retriveFavorites { result in
            switch result {
            case .success(var alreadyFavorites):
                
                switch actionType {
                case .add:
                    guard !alreadyFavorites.contains(favorite) else {
                        completed(.allreadyFavorited)
                        return
                    }
                    
                    alreadyFavorites.append(favorite)
                    
                case .remove:
                    alreadyFavorites.removeAll {$0.login == favorite.login}
                }
                
                completed(save(favorites: alreadyFavorites))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    // MARK: - takeing favorites from defaults

    static func retriveFavorites(completed: @escaping (Result<[Follower], AppError>)-> Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do{
            let decoder = JSONDecoder()
            
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            
            
            completed(.success(favorites)) // işlem başarılı, decode ettiğimizi yukarı atıyoruz
        } catch{
            completed(.failure(.unableToFavorite))
        }
    }
    
    // MARK: - saving favorites to defaults
    
    static func save(favorites: [Follower])-> AppError?{
        
        do{
            let encoder = JSONEncoder()
            let encodedFavorite = try encoder.encode(favorites)
            
            defaults.set(encodedFavorite, forKey: Keys.favorites)
            return nil
        }
        catch {
            return AppError.unableToFavorite
        }
    }

}
