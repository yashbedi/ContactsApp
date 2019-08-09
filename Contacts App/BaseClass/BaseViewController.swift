//
//  BaseViewController.swift
//  Contacts App
//
//  Created by Yash Bedi on 07/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit


class BaseViewController : UIViewController {
    
    // MARK: Public Properties
    
    internal var tableView: UITableView?
    internal var activityIndicator = UIActivityIndicatorView()
    internal var strLabel = UILabel()
    internal let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
    
    // MARK: View Life Cycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        view.backgroundColor = ThemeManager.current().background
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    // MARK: Table View Setup Method
    
    private func tableViewSetup(){
        tableView = UITableView()
        tableView?.translatesAutoresizingMaskIntoConstraints = false
        tableView?.backgroundColor = .clear
        view.addSubview(tableView!)

        tableView?.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        tableView?.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        tableView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        tableView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        tableView?.tableFooterView = UIView()
    }
}
