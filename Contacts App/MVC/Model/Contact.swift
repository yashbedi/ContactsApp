//
//  Contact.swift
//  Contacts App
//
//  Created by Yash Bedi on 07/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//

import Foundation


struct Contact : Decodable {
    
    var id: Int?
    var firstName: String?
    var lastName: String?
    var email: String?
    var mobile: String?
    var image: Data?
    var favourite: Bool
    var profilePic : String?
    var createdAt : String?
    var upadtedAt : String?
    
    init() {
        id = nil
        firstName = nil
        lastName = nil
        email = nil
        mobile = nil
        image = nil
        favourite = false
        profilePic = nil
        createdAt = nil
        upadtedAt = nil
    }
    
    init(from dictionary: [String:Any]) {
        id = dictionary["id"] as? Int ?? 0
        firstName = dictionary["first_name"] as? String ?? ""
        lastName = dictionary["last_name"] as? String ?? ""
        profilePic = dictionary["profile_pic"] as? String ?? ""
        email = dictionary["email"] as? String ?? ""
        mobile = dictionary["phone_number"] as? String ?? ""
        favourite = dictionary["favorite"] as? Bool ?? false
        createdAt = dictionary["created_at"] as? String ?? ""
        upadtedAt = dictionary["updated_at"] as? String ?? ""
    }
    
    func toDictionary() -> [String:Any] {
        var dictionary = [String:Any]()
        if firstName != nil{
            dictionary["first_name"] = firstName
        }
        if lastName != nil{
            dictionary["last_name"] = lastName
        }
        if profilePic != nil{
            dictionary["profile_pic"] = profilePic
        }
        if email != nil{
            dictionary["email"] = email
        }
        if mobile != nil{
            dictionary["phone_number"] = mobile
        }
        if createdAt != nil{
            dictionary["created_at"] = createdAt
        }
        if upadtedAt != nil{
            dictionary["updated_at"] = upadtedAt
        }
        
        dictionary["favourite"] = favourite
        
        return dictionary
    }
}
