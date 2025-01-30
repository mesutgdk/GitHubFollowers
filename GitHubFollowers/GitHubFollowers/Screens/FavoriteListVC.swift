//
//  FavoriteListVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 8.03.2024.
//

import UIKit

final class FavoriteListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
    
        PersistenceManager.retriveFavorites { [weak self] result in
            switch result {
            case .success(let favorites):
                print(favorites)
            case .failure(let error):
                print("Error: \(error)")
            }
        }
        
    }
    
    private func setup(){
        view.backgroundColor = .systemCyan
    }
    
    private func layout(){
        
    }

}
