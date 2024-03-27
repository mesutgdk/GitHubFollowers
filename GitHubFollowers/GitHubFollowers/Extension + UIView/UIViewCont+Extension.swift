//
//  UiViewController+Extension.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 27.03.2024.
//

import UIKit

extension UIViewController{
    
    func presentCustomAlertOnMainThread(title: String, message: String, buttonTitle: String){
        DispatchQueue.main.async {
            let alertVC = CustomAlertVC(alertTitle: title,message: message,buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
        }
    }
}


