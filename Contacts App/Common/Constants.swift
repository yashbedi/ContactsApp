//
//  Constants.swift
//  Contacts App
//
//  Created by Yash Bedi on 08/08/19.
//  Copyright © 2019 Yash Bedi. All rights reserved.
//


import Foundation


struct Constants {
    
    static let kBaseUrl : String                = "http://gojek-contacts-app.herokuapp.com"
    static let kTextMessage : String            = "Voila, How are you doing today.!!!"
    static let kFavIconSelected : String        = "favIconSelected"
    static let kContactDetailsCell : String     = "ContactDetailsCell"
    static let kContactInfoCell : String        = "ContactInfoCell"
    static let kContactDeleteCell : String      = "ContactDeleteCell"
    static let kFavIcon : String                = "favIcon"
    static let kContactsCell: String            = "ContactsCell"
    static let kAddProfilePictureCell : String  = "AddProfilePictureCell"
    static let kMobilePHolder  : String         = "+91 9999999999"
    static let kEmailPHolder  : String          = "john@doe.com"
    static let kJSONError : String              = "JSON Serialization error"
    static let kHeaderValue : String            = "application/json"
    static let kHeaderType : String             = "Content-Type"
    static let kSelectedTheme : String          = "SelectedTheme"
    static let kEmailRegex : String             = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
    static let kMobileNumRegex : String         = "^[0-9+]{0,1}+[0-9]{5,16}$"
    static let kPictureHolder : String          = "profilePlaceholder"
    static let kLoading : String                = "Loading..."
    static let kSomethingWent : String          = "Something went wrong.!\nPlease try again"
    static let kErrorTitle : String             = "Error Occurred"
    static let kInternetError : String          = "Some unknown Error occurred, Check your internet connection and try again.!"
    static let kEmptyFields : String            = "Empty Fields spotted.!!!"
    static let kFieldsCantBeBlank : String      = "No field can be left blank. 😄"
    static let kValid : String                  = "Please enter a valid"
    static let kValidPhone : String             = "Phone Number..!!!"
    static let kValidEmail : String             = "Email Address..!!!"
    static let kSuccess : String                = "Success"
    static let kFName : String                  = "First Name"
    static let kLName : String                  = "Last Name"
    static let kMobile : String                 = "Mobile"
    static let kEmail : String                  = "Email"
    static let kCamera : String                 = "Camera"
    static let kGallery : String                = "Gallery"
    static let kCancel : String                 = "Cancel"
    static let kChooseImage : String            = "Choose Image"
    static let kSure : String                   = "Are you sure.?"
    static let kWantToDelete : String           = "You want to this Delete the Contact."
    static let kYes : String                    = "Yes"
    static let kNo : String                     = "No"
}
