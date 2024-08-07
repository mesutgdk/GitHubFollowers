//
//  UserInfoVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 1.08.2024.
//

import UIKit

final class UserInfoVC: UIViewController {
    
    var userName : Follower

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        createDoneButton()
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

}
