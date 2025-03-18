//
//  UITableView+Extension.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 18.03.2025.
//

import UIKit

extension UITableView{
    
    func reloadDataOnMainThread(){
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
    
    func removeExcessCells(){
        tableFooterView = UIView(frame: .zero)
    }
}
