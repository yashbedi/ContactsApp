//
//  String+Extension.swift
//  Contacts App
//
//  Created by Yash Bedi on 08/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}

extension String {
    var isValidEmail: Bool {
        return NSPredicate(format: "SELF MATCHES %@", Constants.kEmailRegex).evaluate(with: self)
    }
    var isValidPhone: Bool {
        return NSPredicate(format: "SELF MATCHES %@", Constants.kMobileNumRegex).evaluate(with: self)
    }
}
