//
//  CustomAlertVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 25.03.2024.
//

import UIKit

class CustomAlertVC: UIViewController {

    private let containerView   = UIView()
    private let titleLabel      = CustomTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel    = CustomBodyLabel(textAlignment: .center)
    private let actionButton    = CustomButton(backgroundColor: .systemPink, title: "Ok")
    
    var alertTitle : String?
    var message: String?
    var buttonTitle: String?
    
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
    }
    
    private func setup(){
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
    }
    

}
