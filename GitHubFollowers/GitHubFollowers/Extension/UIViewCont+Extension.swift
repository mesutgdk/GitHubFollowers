//
//  UiViewController+Extension.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 27.03.2024.
//

import UIKit
import SafariServices

fileprivate var containerView : UIView!

extension UIViewController{
    
    func presentCustomAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = CustomAlertVC(alertTitle: title,message: message,buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
    
    func showLoadingView(){
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) {
            containerView.alpha         = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingScreen(){
        DispatchQueue.main.async {
            containerView.removeFromSuperview() // reverse process of adding subview
            containerView = nil
        }
    }
    
    // if no follower, this func will be called a new view
    func showEmptyStateView(with message: String, in view: UIView){
        let emtyStateView = CustomEmtyStateView(message: message)
        emtyStateView.frame = view.bounds
        view.addSubview(emtyStateView)
    }
    
    func presentSafariVC(with url: URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        
        DispatchQueue.main.async {
            self.present(safariVC, animated: true)

        }
    }
}


