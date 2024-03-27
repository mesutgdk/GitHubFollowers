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
    private let messageLabel    = CustomBodyLabel(textAlignment: .center)
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
    }
    
    private func setup(){
        containerView.addSubview(titleLabel)
        containerView.addSubview(actionButton)
        view.addSubview(containerView)
        
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
 
    }
    
    private func layout(){
        //containerView
        NSLayoutConstraint.activate([
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
        // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: padding),
            titleLabel.rightAnchor.constraint(equalTo: containerView.rightAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        
        
    }
    
    private func configureAlert(){
        titleLabel.text = alertTitle ?? "Something went wrong"
        
    }
    

}
