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
    
    private let searchButton  = CustomButton(backgroundColor: .systemGreen, title: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
        createDismissKeyboardTapGesture()
        addActionToSearchButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView,
                         userNameTextField,
                         searchButton
        )
        userNameTextField.delegate = self        //textfieldDelegate
    }
    
    private func layout(){
        //logoImageView
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor)
        ])
        //userTextField
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 50),
            userNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            userNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        //actionButton
        NSLayoutConstraint.activate([
            searchButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            searchButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func createDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    // MARK: - Actions- searchbutton action creation
    private func createSearchButtonAction(){
        let action = UIAction{[weak self] _ in
            self?.addActionToSearchButton()
        }
        searchButton.addAction(action, for: .primaryActionTriggered)
    }
    
    private func addActionToSearchButton(){
       
    }
}

extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Go button pressed")
        return true
    }
}
