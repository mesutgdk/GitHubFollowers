//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 21.03.2024.
//

import UIKit

final class FollowerListVC: UIViewController {
    
    enum Section {
        case main
    }
    
    var userName : String = ""
    
    var followers: [Follower] = []
   
    var collectionView : UICollectionView!
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
        configureCollectionView()
        getFollowers()
        configureDataSource()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup(){
        
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func layout(){
        
        NSLayoutConstraint.activate([
        ])
    }
    
    private func configureCollectionView(){
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createThreeColumnFlowLayout())
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self,
                                forCellWithReuseIdentifier: FollowerCell.cellIdentifier)
    }
    
    private func createThreeColumnFlowLayout() -> UICollectionViewFlowLayout{
        
        let width                           = view.bounds.width
        let padding : CGFloat               = 12
        let minimumItemSpacing : CGFloat    = 10
        let availableWidht                  = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidht                       = availableWidht/3
        
        let flowLayout                          = UICollectionViewFlowLayout()
//        flowLayout.scrollDirection              = .vertical
        flowLayout.sectionInset                 = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize                     = CGSize(width: itemWidht, height: itemWidht + 40)
        
        return flowLayout
    }
    
    private func getFollowers(){
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { [weak self] (result) in
            switch result {
            case .success(let followers):
//                print("Followers.count = \(followers.count)")
//                print(followers)
                self?.followers = followers
                self?.updateData()
                
            case .failure(let error):
                self?.presentCustomAlertOnMainThread(title: "Bad News⛈️", message: error.errorDescription, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.cellIdentifier, for: indexPath) as! FollowerCell
            cell.configure(follower: follower)
            return cell
        })
    }
    
    private func updateData(){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)}
        
    }
    
}
