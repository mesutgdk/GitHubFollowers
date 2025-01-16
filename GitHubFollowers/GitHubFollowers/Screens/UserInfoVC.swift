//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 1.08.2024.
//

import UIKit

protocol UserInfoVCDelegate {
    func didTapGitHubProfile()
    func didTapFollowers()
}
final class UserInfoVC: UIViewController {
    
    let headerView  = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    let dateLabel   = CustomBodyLabel(textAlignment: .center, numberOfLines: 1)
    
    var userName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        createDoneButton()
        
        makeNetworkCall(userName: userName)
    }
    
    
    private func setup(){
        view.addSubviews(
            headerView,
            itemViewOne,
            itemViewTwo,
            dateLabel
        )
        view.backgroundColor = .systemBackground
        
        headerView.translatesAutoresizingMaskIntoConstraints    = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints   = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints   = false
        dateLabel.translatesAutoresizingMaskIntoConstraints    = false
        
//        itemViewOne.backgroundColor = .systemRed
//        itemViewTwo.backgroundColor = .systemBlue
        
    }
    
    private func layout(){
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
        
        NSLayoutConstraint.activate([
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor, constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor, constant: padding),
            dateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            dateLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            dateLabel.heightAnchor.constraint(equalToConstant: 18)

        ])
    }
    
    private func createDoneButton(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .secondaryLabel
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }

    
    private func makeNetworkCall(userName: String?){
        guard let userName = userName else {return}
        
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let user):
//                print(user)
               
                self.configureUIElements(with: user)
                
            case .failure(let error):
                self.presentCustomAlertOnMainThread(title: "Bad News⛈️", message: error.errorDescription, buttonTitle: "Ok")
            }
        }
    }
    
    private func configureUIElements( with user: User){
        DispatchQueue.main.async {
            
            let repoInfoVC = AppFollowerItemInfoVC(user: user)
            repoInfoVC.delegate = self
            
            self.addVC(childVC: AppFollowerRepoItemVC(user: user), to: self.itemViewOne)
            self.addVC(childVC: AppFollowerItemVC(user: user), to: self.itemViewTwo)
            self.addVC(childVC: AppUserInfoHeaderVC(user: user), to: self.headerView)
            // dateconverter used to make string to date to string
            self.dateLabel.text = "GitHub Since " + user.createdAt.convertToDisplayDate()
        }
    }
    
    private func addVC(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
}
// MARK: - UserInfoVCDelegate
extension UserInfoVC: UserInfoVCDelegate {
    func didTapGitHubProfile() {
        // to do : show safari view controller
    }
    
    func didTapFollowers() {
        // to do : dismiss this VC
        // tell foller list screen the new user
    }
}

