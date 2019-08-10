//
//  BaseView.swift
//  Contacts App
//
//  Created by Yash Bedi on 09/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation

protocol BaseView {
    func startLoading()
    func stopLoading()
}

extension BaseView {
    func startLoading() {}
    func stopLoading() {}
}
