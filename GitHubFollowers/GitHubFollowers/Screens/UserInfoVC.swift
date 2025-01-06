//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 1.08.2024.
//

import UIKit

final class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    
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
            itemViewTwo
        )
        view.backgroundColor = .systemBackground
        
        headerView.translatesAutoresizingMaskIntoConstraints    = false
        itemViewOne.translatesAutoresizingMaskIntoConstraints   = false
        itemViewTwo.translatesAutoresizingMaskIntoConstraints   = false
        
//        itemViewOne.backgroundColor = .systemRed
//        itemViewTwo.backgroundColor = .systemBlue
        
    }
    
    private func layout(){
        let padding: CGFloat    = 20
        let itemHeight: CGFloat = 140
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
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
    }
    
    private func createDoneButton(){
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.barTintColor = .secondaryLabel
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }

    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
    private func makeNetworkCall(userName: String?){
        guard let userName = userName else {return}
        
        NetworkManager.shared.getUserInfo(for: userName) { [weak self] result in
            guard let self = self else {return}
            
            switch result {
            case .success(let user):
//                print(user)
                DispatchQueue.main.async {
                    self.addVC(childVC: CustomUserInfoHeaderVC(user: user), to: self.headerView)
                    self.addVC(childVC: CustomRepoItemVC(user: user), to: self.itemViewOne)
                    self.addVC(childVC: CustomItemInfoVC(user: user), to: self.itemViewTwo)
                }
                
            case .failure(let error):
                self.presentCustomAlertOnMainThread(title: "Bad News⛈️", message: error.errorDescription, buttonTitle: "Ok")
            }
        }
    }
    
    private func addVC(childVC: UIViewController, to containerView: UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}
