//
//  SearchVCViewController.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 8.03.2024.
//

import UIKit

final class SearchVC: UIViewController {

    private let logoImageView = {
        let logoImageView = UIImageView()
        logoImageView.translatesAutoresizingMaskIntoContraints(false)
        
        return logoImageView
    }()
    
    private let userNameTextField = {
        let userNameTextField = CustomTextField()
        userNameTextField.translatesAutoresizingMaskIntoConstraints = false
        
        return userNameTextField
    }
    
    private let callToActionButton = CustomButton(backgroundColor: .black, title: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
    }
    
    private func setup(){
        view.backgroundColor = .systemRed
    }
    
    private func layout(){
        
    }
}
