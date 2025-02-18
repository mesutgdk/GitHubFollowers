//
//  CustomDataLoadingVC.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 18.02.2025.
//

import UIKit
import SafariServices

// MARK: - CustomVC not to extend uiviewcontroller, go on this vc by subclass

class CustomDataLoadingVC: UIViewController {
    
    var containerView : UIView!
    
    func dismissLoadingScreen2(){
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview() // reverse process of adding subview
            self.containerView = nil
        }
    }
    
    // if no follower, this func will be called a new view
    func showEmptyStateView2(with message: String, in view: UIView){
        let emtyStateView = CustomEmtyStateView(message: message)
        emtyStateView.frame = view.bounds
        view.addSubview(emtyStateView)
    }
    
    func presentSafariVC2(with url: URL){
        let safariVC = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor = .systemGreen
        
        DispatchQueue.main.async {
            self.present(safariVC, animated: true)

        }
    }
}
