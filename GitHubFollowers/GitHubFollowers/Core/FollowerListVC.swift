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
    
    var userName : String?
    
    var followers: [Follower] = []
    
    var page: Int = 1
   
    var collectionView : UICollectionView!
    
    var dataSource : UICollectionViewDiffableDataSource<Section, Follower>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        
        configureCollectionView()
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
  
    private func getFollowers(userName: String?, page: Int){
        guard let userName = userName else {
             return
        }
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { [weak self] (result) in
            guard let self = self else {return}
            
            switch result {
            case .success(let followers):
//                print("Followers.count = \(followers.count)")
//                print(followers)
                self.followers = followers
                self.updateData()
                
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
    
    private func updateData(){
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
        
//        print("offSetY          = \(offSetY)")
//        print("contentHeight    = \(contentHeight)")
//        print("height           = \(height)")
        
        if offSetY > contentHeight - height {
            page += 1
            getFollowers(userName: userName, page: page)
        }
    }
}
