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
        logoImageView.image = Images.ghLogo
        return logoImageView
    }()
    
    private let userNameTextField   = CustomTextField()
    
    private let searchButton  = CustomButton(backgroundColor: .systemGreen, title: "Get Followers", systemImageName: SFSymbols.searchButton)
    
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
        setupKeyboardHiding()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
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

    // MARK: - Actions- searchbutton action creation
    private func createSearchButtonAction(){
        let action = UIAction{[weak self] _ in
            self?.addActionToSearchButton()
        }
        searchButton.addAction(action, for: .primaryActionTriggered)
    }
    
    private func addActionToSearchButton(){
        errorMessageLabel.isHidden = true
        
        guard !userNameTextField.text!.isEmpty else { // textField un-empty guard statement
            presentCustomAlertOnMainThread(title: "Empty Username", message: "Please enter a username. We need to know who to look for 😁", buttonTitle: "Ok")
            showErrorMessage()
            return
        }
        
        // while pushing screen, action button and keyboard mix bug occurs, getting rid of this with both way
//        userNameTextField.resignFirstResponder()
        view.endEditing(true)
        
        let userName = userNameTextField.text!
        
        let followerVC = FollowerListVC(username: userName)

        //        print(followerVC.userName)
        
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.pushViewController(followerVC, animated: true)
    }
    
    //ErrorMessage below textfield
    private func showErrorMessage(){
        errorMessageLabel.text = "No Username"
        errorMessageLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now()+2.5 ){
            self.errorMessageLabel.isHidden = true
        }
    }
}

extension SearchVC{
    // MARK: - taping outside of keyboard disappears the keyboard
    private func createDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }

    // MARK: - recognizeTapGester - Keyboard appear and Disappear - Pushing screen up
    private func setupKeyboardHiding(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) { // keyboard bilgilerini burdan alıyoruz
        //        view.frame.origin.y = view.frame.origin.y - 200 // it push all view 200 pxl up
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField else {return}
        
//                print("foo - userInfo \(userInfo)")
//                print("foo - keyboardFrame \(keyboardFrame)")
//                print("foo - currenttextField \(currentTextField)")
//
        // check if the top of the keyboard is above the bottom of the currently focused textbox
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        // let textFieldBottomY = currentTextField.frame.origin.y + currentTextField.frame.size.height
        
        // textfield kendi koordinat sisteminde dönüyor, çalışmıyor, yukarıdaki yerine parent view koordinat sistemine çevireceğiz
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        
        let textFieldBottomY = (convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height)
        
        // if textField bottom is below keyboard bottom - push the frame up
        if textFieldBottomY > keyboardTopY {
            //adjust view up
            let textBoxY = convertedTextFieldFrame.origin.y
            let newFrameY = (textBoxY - keyboardTopY/2) * -1
            view.frame.origin.y = newFrameY
        }
        
    }
    @objc func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y = 0
    }
}

extension SearchVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true) // to disappear the keyboard after pressing go
//        print("Go button pressed")
        return true
    }
}
