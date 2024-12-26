//
//  CustomItemInfoVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 26.12.2024.
//

import UIKit

final class CustomItemInfoVC: UIViewController {

    let stackView = UIStackView()
    let itemInfoViewOne = CustomItemInfoView()
    let itemInfoViewTwo = CustomItemInfoView()
    let actionButton    = CustomButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        configureStackView()
    }
    private func setup(){
        view.layer.cornerRadius = 18
        view.backgroundColor    = .secondarySystemBackground
        
        view.addSubviews(
            stackView,
            actionButton
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        actionButton.translatesAutoresizingMaskIntoConstraints = false
        
 
    }
    
    private func layout(){
        let padding: CGFloat = 16
        //stackView
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            stackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        //actionButton
        NSLayoutConstraint.activate([
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }
    
    private func configureStackView(){
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(itemInfoViewOne)
        stackView.addArrangedSubview(itemInfoViewTwo)

    }

}
