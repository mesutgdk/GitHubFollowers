//
//  Date+Extension.swift
//  GitHubFollowers
//
//  Created by Mesut Gedik on 15.01.2025.
//
import Foundation

extension Date {
    func convertDateToMouthYearFormat() -> String{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "MMM yyyy"
        return dateFormater.string(from: self)
    }
}
