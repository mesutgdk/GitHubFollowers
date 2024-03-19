//
//  SearchVCViewController.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 8.03.2024.
//

import UIKit

final class SearchVC: UIViewController {

    private let logoImageView       = {
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoContraints(false)
        logoImageView.image = UIImage(named: "gh-logo")
        return logoImageView
    }()
    
    private let userNameTextField   = CustomTextField()
    
    private let callToActionButton  = CustomButton(backgroundColor: .black, title: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setup(){
        view.backgroundColor = .systemRed
        view.addSubviews(logoImageView
//                         userNameTextField,
//                         callToActionButton
        )
    }
    
    private func layout(){
        //logoImageView
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor)
        ])
        //userTextField
        NSLayoutConstraint.activate([
            
        ])
        //actionButton
        NSLayoutConstraint.activate([
            
        ])
    }
}
