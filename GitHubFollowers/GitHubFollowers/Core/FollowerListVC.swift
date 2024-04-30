//
//  FollowerListVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 21.03.2024.
//

import UIKit

final class FollowerListVC: UIViewController {

    var userName : String = ""
    
    let collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 2, left: 2, bottom: 2, right: 2)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor = .systemPink
        collectionView.register(FollowerCell.self,
                                forCellWithReuseIdentifier: FollowerCell.cellIdentifier)
        return collectionView
    } ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        getFollowers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup(){
        view.addSubview(collectionView)
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func layout(){
       
        NSLayoutConstraint.activate([
        ])
    }
    
    private func setupCollectionViewSetup(){
        
        collectionView.frame                = view.bounds
        let width                           = view.bounds.width
        let padding : CGFloat               = 12
        let minimumItemSpacing : CGFloat    = 10
        let availableWidht = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidht = availableWidht/3
        
    }
    private func getFollowers(){
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { [weak self] (result) in
            switch result {
            case .success(let followers):
                print("Followers.count = \(followers.count)")
                print(followers)
            case .failure(let error):
                self?.presentCustomAlertOnMainThread(title: "Bad News⛈️", message: error.errorDescription, buttonTitle: "Ok")
            }
        }
        
        
//        NetworkManager.shared.getFollowersByOldWayWithoutResultType(for: userName, page: 1) { [weak self] (followers, errorMessage) in
//            guard let followers = followers else {
//                self?.presentCustomAlertOnMainThread(title: "Bad News⛈️", message: errorMessage!.errorDescription, buttonTitle: "Ok")
//                return
//            }
//            print("Followers.count = \(followers.count)")
//            print(followers)
//        }
    }

}
