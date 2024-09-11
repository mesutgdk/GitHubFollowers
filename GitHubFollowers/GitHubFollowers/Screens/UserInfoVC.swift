//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 1.08.2024.
//

import UIKit

final class UserInfoVC: UIViewController {
    
    let headerView = UIView()
    
    var userName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        createDoneButton()
        
        makeNetworkCall(userName: userName)
    }
    
    
    private func setup(){
        view.addSubview(headerView)
        view.backgroundColor = .systemBackground
        
        headerView.translatesAutoresizingMaskIntoConstraints = false

    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leftAnchor.constraint(equalTo: view.leftAnchor),
            headerView.rightAnchor.constraint(equalTo: view.rightAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
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
