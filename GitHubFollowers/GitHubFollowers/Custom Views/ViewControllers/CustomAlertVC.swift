//
//  CustomAlertVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 25.03.2024.
//

import UIKit

class CustomAlertVC: UIViewController {
    
    private let containerView   = {
        let containerView = UIView()
        containerView.backgroundColor = .systemBackground
        containerView.addCornerRadiusAndShadow(containerView,
                                               cornerRadius: 16,
                                               borderWith: 2,
                                               borderColor: .white,
                                               hasShadow: false)
        return containerView
    } ()
    
    private let titleLabel      = CustomTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel    = CustomBodyLabel(textAlignment: .center, numberOfLines: 4)
    private let actionButton    = CustomButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle : String?
    var message: String?
    var buttonTitle: String?
    
    let padding: CGFloat = 20
    
    init(alertTitle: String?    = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle         = alertTitle
        self.message            = message
        self.buttonTitle        = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        
        configureAlert()
    }
    
    private func setup(){
        view.addSubview(containerView)
        containerView.addSubview(titleLabel)
        containerView.addSubview(messageLabel)
        containerView.addSubview(actionButton)
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
    }
    
    private func layout(){
        //containerView
        if UIDevice.isIphone {
            NSLayoutConstraint.activate([
                containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                containerView.widthAnchor.constraint(equalToConstant: 280),
                containerView.heightAnchor.constraint(equalToConstant: 220)
            ])
        } else {
            NSLayoutConstraint.activate([
                containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                containerView.widthAnchor.constraint(equalToConstant: 320),
                containerView.heightAnchor.constraint(equalToConstant: 250)
            ])
        }
        
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        //messageLabel
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,constant: 8),
            messageLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding),
            messageLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        ])
        
        // actionButton
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding),
            actionButton.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    private func configureAlert(){
        titleLabel.text = alertTitle ?? "Something went wrong"
        messageLabel.text = message ?? "Unable to complete request"
        actionButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        
        // createActionToDismissAlert
        let action = UIAction{[weak self] _ in
            self?.dismissAlert()
        }
        actionButton.addAction(action, for: .primaryActionTriggered)
    }
    
    private func dismissAlert(){
        dismiss(animated: true)
    }
}
