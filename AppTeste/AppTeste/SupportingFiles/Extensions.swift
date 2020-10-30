//
//  Extensions.swift
//  AppTeste
//
//  Created by marcel.soares on 25/10/20.
//

import Foundation
import UIKit

extension Double {
    func moneyToStr() -> String {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.usesGroupingSeparator = true
        currencyFormatter.numberStyle = .currency
        currencyFormatter.locale = Locale.current
        return currencyFormatter.string(from: NSNumber(value: self))!
    }
    
    func epochToDateStr() -> String {
        let date = NSDate(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT") as TimeZone?
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date as Date)
    }
    
    func epochToTimeStr() -> String {
        let date = NSDate(timeIntervalSince1970: self)
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(abbreviation: "GMT") as TimeZone?
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter.string(from: date as Date)
    }
}

extension UIFont {
    static func titleFont(size: CGFloat) -> UIFont {
        return UIFont.boldSystemFont(ofSize: size)
    }
    
    static func detailFont(size: CGFloat) -> UIFont {
        return UIFont.systemFont(ofSize: size)
    }
}


