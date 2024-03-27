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
    
    private let errorMessageLabel: UILabel = {
        let errorMessageLabel = UILabel()
        errorMessageLabel.translatesAutoresizingMaskIntoConstraints = false
        errorMessageLabel.textAlignment = .center
        errorMessageLabel.textColor = .systemRed
        errorMessageLabel.numberOfLines = 0
        errorMessageLabel.isHidden = true
        return errorMessageLabel
    }()
    
    var isUserNameEntered : Bool {
        return !userNameTextField.text!.isEmpty // textfieldin doluluğu kontrolü
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        
        createDismissKeyboardTapGesture()
        createSearchButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        view.addSubviews(logoImageView,
                         userNameTextField,
                         errorMessageLabel,
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
        //errorLAbel
        NSLayoutConstraint.activate([
            errorMessageLabel.topAnchor.constraint(equalTo: userNameTextField.bottomAnchor, constant: 10),
            errorMessageLabel.leftAnchor.constraint(equalTo: userNameTextField.leftAnchor),
            errorMessageLabel.rightAnchor.constraint(equalTo: userNameTextField.rightAnchor)
        ])
        //actionButton
        NSLayoutConstraint.activate([
            searchButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 50),
            searchButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -50),
            searchButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            searchButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    private func createDismissKeyboardTapGesture(){ // taping outside of keyboard disappears the keyboard
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
        let followerVC = FollowerListVC()
        errorMessageLabel.isHidden = true
        
        guard !userNameTextField.text!.isEmpty else { // textField un-empty guard statement
            print("TextField is Empty")
            errorMessageLabel.text = "Username can not be empty"
            errorMessageLabel.isHidden = false
            DispatchQueue.main.asyncAfter(deadline: .now()+2.5 ){
                self.errorMessageLabel.isHidden = true
            }
            return
        }
        
        followerVC.userName = userNameTextField.text!
        followerVC.title    = userNameTextField.text!
        //        print(followerVC.userName)
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.pushViewController(followerVC, animated: true)
    }
}

extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true) // to disappear the keyboard after pressing go
        print("Go button pressed")
        return true
    }
}
