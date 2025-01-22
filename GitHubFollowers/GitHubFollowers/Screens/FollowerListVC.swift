//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 21.03.2024.
//

import UIKit

protocol FollowerListVCDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

final class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var userName            : String?
    
    var followers           : [Follower]    = []
    var filteredFollowers   : [Follower]    = []
    
    var page                : Int           = 1
    
    var hasMorePage         : Bool          = true
   
    var collectionView      : UICollectionView!
    
    var dataSource          : UICollectionViewDiffableDataSource<Section, Follower>!
    
    var isSearching         : Bool          = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
        configureCollectionView()
        configureSearchController()
        
        getFollowers(userName: userName, page: page)
        configureDataSource()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.hidesSearchBarWhenScrolling = false // sayfa açıldığında searchbarı otomatik açık gösteriyor
    }
    
    private func layout(){
        
        NSLayoutConstraint.activate([
        ])
    }
    
    private func configureCollectionView(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
//        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self,
                                forCellWithReuseIdentifier: FollowerCell.cellIdentifier)
        collectionView.delegate = self
    }
  
    // MARK: - search for a follower
    
    private func configureSearchController(){
        let searchController                                    = UISearchController()
                        
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.delegate                     = self
        searchController.searchBar.placeholder                  = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }
    
    private func getFollowers(userName: String?, page: Int){
        // show activity indicator while network call
        showLoadingView()
        
        guard let userName = userName else {
             return
        }
        
        NetworkManager.shared.getFollowers(for: userName, page: page) { [weak self] (result) in
            guard let self = self else {return}
            
            //            #warning("Call Dismiss")
            self.dismissLoadingScreen() // removing activty indicator
            
            switch result {
            case .success(let followers):
                if followers.count < 100 {self.hasMorePage = false}
                
                if followers.isEmpty {
                    let message = "This User doesn't have any follewers. Let's follow them😇"
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: message, in: self.view)
                    }
                    return
                }
                
                self.followers.append(contentsOf: followers) // eşitlemektense append etmek yeni sayfalar için must
                
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentCustomAlertOnMainThread(title: "Bad News⛈️", message: error.errorDescription, buttonTitle: "Ok")
            }
        }
    }

    // MARK: - DataSource

    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.cellIdentifier, for: indexPath) as? FollowerCell else {return UICollectionViewCell()}
            
            cell.configure(follower: follower)
            return cell
        })
    }
    
    private func updateData(on followers : [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)}
        
    }
}

extension FollowerListVC: UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY             = scrollView.contentOffset.y
        let contentHeight       = scrollView.contentSize.height
        let height              = scrollView.frame.size.height

        if offSetY > contentHeight - height {
            
            guard hasMorePage else {return}
            page += 1
            getFollowers(userName: userName, page: page)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // to determine whether the chosen item is in filtered array or original follower array
        let determinedFollowers     = isSearching ? filteredFollowers : followers
        
        let follower                = determinedFollowers[indexPath.item]
        
        let destinationVC           = UserInfoVC()
        
        destinationVC.userName = follower.login
        destinationVC.delegate = self
        
        let navContDestVC           = UINavigationController(rootViewController: destinationVC)
        
        
        present(navContDestVC, animated: true)
        
    }
}

extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filterText = searchController.searchBar.text, !filterText.isEmpty else {
            updateData(on: followers)
            return
        }
        
        isSearching = true
        
        filteredFollowers = followers.filter{
            $0.login.lowercased().contains(filterText.lowercased())
        }
        updateData(on: filteredFollowers)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        print("cancel button pressed")
        isSearching = false
        updateData(on: followers)
    }
}

extension FollowerListVC : FollowerListVCDelegate {
    func didRequestFollowers(for username: String) {
        // get followers for that user
        
        self.userName   = username
        title           = username
        page            = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(userName: username, page: page)
        
    }
    
}
