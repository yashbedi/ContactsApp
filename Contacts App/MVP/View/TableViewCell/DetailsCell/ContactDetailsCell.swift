//
//  ContactDetailsCell.swift
//  Contacts App
//
//  Created by Yash Bedi on 06/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import UIKit

class ContactDetailsCell: UITableViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var bgView: GradientView!
    @IBOutlet weak var favouriteButton: UIButton!
    @IBOutlet weak var emailButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    
    internal var contact: Contact?
    fileprivate var isFav = false
    
    // MARK: View Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
        profileImageView.alpha = 0
        profileImageView.contentMode = .scaleAspectFill
        bgView.startColor = ThemeManager.current().background
        messageButton.addTarget(self, action: #selector(openMessageApp), for: .touchUpInside)
        callButton.addTarget(self, action: #selector(openCallApp), for: .touchUpInside)
        emailButton.addTarget(self, action: #selector(openMailApp), for: .touchUpInside)
        favouriteButton.addTarget(self, action: #selector(toggleFavourite), for: .touchUpInside)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = UIColor.white.cgColor
        profileImageView.layer.masksToBounds = true
        UIView.animate(withDuration: 0.3) {
            self.profileImageView.alpha = 1
        }
    }
    
    internal func setData(with contact: Contact){
        self.contact = contact
        nameLabel.text = (contact.firstName ?? "") + " " + (contact.lastName ?? "")
        favouriteButton.setImage(UIImage(named: (contact.favourite) ? Constants.kFavIconSelected : Constants.kFavIcon), for: .normal)
        
        if let urlStr = contact.profilePic, urlStr.contains("http"),let url = URL(string: urlStr) {
            NetworkManager.shared.getImage(from: url) { _data in
                DispatchQueue.main.async {
                    self.profileImageView.image = UIImage(data: _data)
                }
            }
        }
    }
    
    @objc internal func openMessageApp(){
        guard
            let mobileNum = contact?.mobile, mobileNum.count > 0 else {return}
        let sms: String = "sms:\(mobileNum.removingWhitespaces())&body=\(Constants.kTextMessage)"
        let strURL: String = sms.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        UIApplication.shared.open(URL.init(string: strURL)!, options: [:], completionHandler: nil)
    }
    
    @objc internal func openCallApp(){
        guard
            let mobileNum = contact?.mobile, mobileNum.count > 0 else {return}
        if let url = URL(string: "tel://\(mobileNum.removingWhitespaces())"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        }
    }
    
    @objc internal func openMailApp(){
        guard
            let email = contact?.email, email.count > 0 else {return}
        let appURL = URL(string: "mailto:\(email)")!
        UIApplication.shared.open(appURL as URL, options: [:], completionHandler: nil)
    }
    
    @objc internal func toggleFavourite(){
        isFav = !isFav
        favouriteButton.setImage(UIImage(named: isFav ? Constants.kFavIconSelected : Constants.kFavIcon), for: .normal)
    }
}
