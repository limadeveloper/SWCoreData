//
//  UserModel.swift
//  SWCoreData
//
//  Created by John Lima on 15/09/16.
//  Copyright © 2016 John Lima. All rights reserved.
//

import CoreData

enum UserAttributes: String {
    case Name = "name"
    case LastName = "lastName"
    case Age = "age"
    case Gender = "gender"
    case Language = "language"
    case Country = "country"
    case Email = "email"
    case Id = "id"
}

class UserModel {
    
    var name: String?
    var lastName: String?
    var age: Int?
    var gender: String?
    var language: String?
    var country: String?
    var email: String?
    var id: Int?
    
    init() {}
    
    init(data: Dictionary<String,AnyObject>) {
        if
            let email = data[UserAttributes.Email.rawValue] as? String,
            let id = data[UserAttributes.Id.rawValue] as? Int {
            
            self.email = email
            self.id = id
            
            if let name = data[UserAttributes.Name.rawValue] as? String {
                self.name = name
            }
            if let lastName = data[UserAttributes.LastName.rawValue] as? String {
                self.lastName = lastName
            }
            if let age = data[UserAttributes.Age.rawValue] as? Int {
                self.age = age
            }
            if let gender = data[UserAttributes.Gender.rawValue] as? String {
                self.gender = gender
            }
            if let language = data[UserAttributes.Language.rawValue] as? String {
                self.language = language
            }
            if let country = data[UserAttributes.Country.rawValue] as? String {
                self.country = country
            }
        }
    }
}

extension UserModel {
    
    
    
}
