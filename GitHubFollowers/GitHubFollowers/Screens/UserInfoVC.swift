//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 1.08.2024.
//

import UIKit

final class UserInfoVC: UIViewController {
    
    var userName : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        createDoneButton()
        
        makeNetworkCall(userName: userName)
    }
    
    
    private func setup(){
        view.backgroundColor = .systemBackground

    }
    
    private func layout(){
        
    }
    
    
    private func createDoneButton(){
        navigationController?.navigationBar.isHidden = false
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
                print(user)
            case .failure(let error):
                self.presentCustomAlertOnMainThread(title: "Bad News⛈️", message: error.errorDescription, buttonTitle: "Ok")
            }
        }
        
    }
}
