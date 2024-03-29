//
//  UserModel.swift
//  crudoOperation
//
//  Created by Hyperlink on 20/09/23.
//

import Foundation
import UIKit


// MARK: - SectionModel Class

class SectionModel {
    
    var sectionName : String?
    var sectionData : [UserModel]
    
    init(_ sectionName: String,_ sectionData: [UserModel]){
        
        self.sectionName  = sectionName
        self.sectionData  = sectionData
    }
    
}

//---------------------------------------

// MARK: - UserModel Class
class UserModel {
    
    var id          : Int?
    let name        : String?
    let email       : String?
    let dob         : String?
    let category    : String?
    let bio         : String?
    let code        : String?
    let phoneNumber : String?
    let image       : UIImage?

    init(_ userName: String,_ userEmail: String,_ userDob: String, _ userCategory: String,_ userBio: String,_ userImage: UIImage,_ phoneNumber: String,_ code: String,_ userId: Int? = nil){
        
        self.id          = userId
        self.name        = userName
        self.email       = userEmail
        self.dob         = userDob
        self.category    = userCategory
        self.bio         = userBio
        self.image       = userImage
        self.code        = code
        self.phoneNumber = phoneNumber
    
    }
  
}


