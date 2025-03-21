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
    
    var userName                : String?
    
    var followers               : [Follower]    = []
    var filteredFollowers       : [Follower]    = []
    
    var page                    : Int           = 1
    
    var hasMorePage             : Bool          = true
   
    var collectionView          : UICollectionView!
    
    var dataSource              : UICollectionViewDiffableDataSource<Section, Follower>!
    
    var isSearching             : Bool          = false
    
    var isLoadingMoreFollowers  : Bool           = false
    
    init(username:String){
        super.init(nibName: nil, bundle: nil)
        self.userName   = username
        title           = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        // To add favorite button
        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        // To see profile button
        let profileButton = UIBarButtonItem(image: SFSymbols.profile , style: .plain, target: self, action: #selector(eyesButtonTapped))
        navigationItem.rightBarButtonItems = [addButton, profileButton]
        
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
        isLoadingMoreFollowers = true // it is the start of loading
        
        guard let userName = userName else {
            isLoadingMoreFollowers = false
             return
        }
        NetworkManager.shared.getFollowers(for: userName, page: page)
        // the OldWayWithResult of Networkcall
//        NetworkManager.shared.getFollowersTheOldWayWithResultType(for: userName, page: page) { [weak self] (result) in
//            guard let self = self else {
//                self?.isLoadingMoreFollowers = false
//                return
//            }
//            
//            //            #warning("Call Dismiss")
//            self.dismissLoadingScreen() // removing activty indicator
//            
//            switch result {
//            case .success(let followers):
//                
//                self.updateUI(with: followers)
//                
//            case .failure(let error):
//                self.presentCustomAlertOnMainThread(title: "Bad News⛈️", message: error.errorDescription, buttonTitle: "Ok")
//            }
//            isLoadingMoreFollowers = false  // no, it is ending-loading
//        }
    }
    
    private func updateUI(with followers: [Follower]){
    
        if followers.count < 100 {self.hasMorePage = false}
        
        if followers.isEmpty {
            let message = "This User doesn't have any follewers. Let's follow them😇"
            DispatchQueue.main.async {
                self.showEmptyStateView(with: message, in: self.view)
            }
            self.isLoadingMoreFollowers = false
            return
        }
        
        self.followers.append(contentsOf: followers) // eşitlemektense append etmek yeni sayfalar için must
        
        self.updateData(on: self.followers)
    }
    
    
    private func updateData(on followers : [Follower]){
        var snapshot = NSDiffableDataSourceSnapshot<Section,Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {self.dataSource.apply(snapshot, animatingDifferences: true)}
        
    }

    // MARK: - DataSource
    private func configureDataSource(){
        dataSource = UICollectionViewDiffableDataSource<Section,Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.cellIdentifier, for: indexPath) as? FollowerCell else {return UICollectionViewCell()}
            
            cell.configure(follower: follower)
            return cell
        })
    }
    

    @objc func addButtonTapped(){
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            
            guard let self = self else {return}
            
            dismissLoadingScreen()
            
            switch result {
            case .success(let user):
                self.addUserToFavorited(user: user)

            case .failure(let error):
                self.presentCustomAlertOnMainThread(title: "Something went wrong", message: error.errorDescription, buttonTitle: "Ok")
            }
        }
    }
    
    private func addUserToFavorited(user: User){
        let favoriteUser = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favoriteUser, actionType: .add) { [weak self] error in
            guard let self = self else {return}
            
            guard let error = error else {
                presentCustomAlertOnMainThread(title: "Success!", message: "You have successfully added this user🎉", buttonTitle: "Welldone")
                
                return
            }
            self.presentCustomAlertOnMainThread(title: "Something went wrong", message: error.errorDescription, buttonTitle: "Ok")
            
        }
    }
    
    
    @objc func eyesButtonTapped(){
        showLoadingView()
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            
            guard let self = self else {return}
            dismissLoadingScreen()
            
            switch result {
            case .success(let user):
                                
                guard let url = URL(string: user.htmlUrl) else {
                    presentCustomAlertOnMainThread(title: "Invalid URL", message: "Url attached to this user is invalid", buttonTitle: "Ok")
                    return
                }
                presentSafariVC(with: url)
              
            case .failure(let error):
                self.presentCustomAlertOnMainThread(title: "Something went wrong", message: error.errorDescription, buttonTitle: "Ok")
            }
        }

    }
}
// MARK: - uicollectionviewdelegate
extension FollowerListVC: UICollectionViewDelegate{
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offSetY             = scrollView.contentOffset.y
        let contentHeight       = scrollView.contentSize.height
        let height              = scrollView.frame.size.height

        if offSetY > contentHeight - height {
            
            guard hasMorePage, !isLoadingMoreFollowers else {return} // 100den fazla follower ve acaba yükleme yapıyor mu, üstüste yüklemesin
            page += 1
            getFollowers(userName: userName, page: page)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // to determine whether the chosen item is in filtered array or original follower array
        let determinedFollowers     = isSearching ? filteredFollowers : followers
        
        let follower                : Follower
        
        if !determinedFollowers.isEmpty {follower = determinedFollowers[indexPath.item]}
        else {follower = followers[indexPath.item]}
        
//        let checkedFollowers                    = determinedFollowers.isEmpty ? followers : filteredFollowers
//        let follower                = determinedFollowers[indexPath.item]
//        let follower                = checkedFollowers[indexPath.item]
//        
        let destinationVC           = UserInfoVC()
        
        destinationVC.userName = follower.login
        destinationVC.delegate = self
        
        let navContDestVC           = UINavigationController(rootViewController: destinationVC)
        
        
        present(navContDestVC, animated: true)
        
    }
}
// MARK: - uisearchbardelegate
extension FollowerListVC: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filterText = searchController.searchBar.text, !filterText.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
//            isSearching = false    bunu eklersen 'searchBarCancelButtonClicked' ve 'UISearchBarDelegate' ihtiyaç duymazsın
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

extension FollowerListVC : UserInfoVCDelegate {
    func didRequestFollowers(for username: String) {
        // get followers for that user
        
        self.userName   = username
        title           = username
        page            = 1
        followers.removeAll()
        filteredFollowers.removeAll()
//        collectionView.setContentOffset(.zero, animated: true)
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        getFollowers(userName: username, page: page)
        
    }
    
}
