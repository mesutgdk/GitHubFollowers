//
//  FavoriteListVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 8.03.2024.
//

import UIKit

final class FavoriteListVC: UIViewController {

    
    let tableView               = UITableView()
    var favorites:[Follower]    = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setup()
        layout()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // viewDidLoad pulls one time, if u change screen it cant refresh, so viewDidAppear is a good solution.
        getFavorites()
    }
    private func setup(){
        //configureVC
        view.backgroundColor    = .systemBackground
        title                   = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        
        //configureTableView
        view.addSubview(tableView)
        configureTableView()
        
    }
    
    private func layout(){
        
    }
    
    private func configureTableView(){
        tableView.frame         = view.bounds
        tableView.rowHeight     = 80
        
        tableView.dataSource    = self
        tableView.delegate      = self
        tableView.register(FavoriteTVCell.self, forCellReuseIdentifier: FavoriteTVCell.cellIdentifier)
    }
    
    func getFavorites(){
        PersistenceManager.retriveFavorites { [weak self] result in
            guard let self = self else {return}
            switch result {
            case .success(let favorites):

                if favorites.isEmpty {
                    self.showEmptyStateView(with: "No Favorites?\nAdd some on the followers!", in: self.view)
                } else {
                    self.favorites = favorites
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        self.view.bringSubviewToFront(self.tableView)
                    }
                }
            case .failure(let error):
                self.presentCustomAlertOnMainThread(title: "Something went wrong", message: error.errorDescription, buttonTitle: "Ok")
            }
        }
    }

}
extension FavoriteListVC: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTVCell.cellIdentifier) as! FavoriteTVCell
        let favorites = favorites[indexPath.row]
        cell.configure(favorite: favorites)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite            = favorites[indexPath.row]
        let destinationVC       = FollowerListVC()
        
        destinationVC.userName  = favorite.login
        destinationVC.title     = favorite.login
        
        navigationController?.pushViewController(destinationVC, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite            = favorites[indexPath.row]
        favorites.remove(at: indexPath.row)
        
        tableView.deleteRows(at: [indexPath], with: .left)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] error in
            guard let self = self else { return }
            
            guard let error = error else {return}
            
            self.presentCustomAlertOnMainThread(title: "Unable  to remove", message: error.errorDescription, buttonTitle: "Ok")
        }
    }
}
