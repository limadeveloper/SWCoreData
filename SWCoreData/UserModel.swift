//
//  UserModel.swift
//  SWCoreData
//
//  Created by John Lima on 15/09/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
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
    case Password = "password"
    case Id = "id"
}

enum UserKeys: String {
    case Name = "Name"
    case LastName = "Last Name"
    case Age = "Age"
    case Gender = "Gender"
    case Language = "Language"
    case Country = "Country"
    case Email = "Email"
    case Password = "Password"
    case Id = "Id"
}

class UserModel {
    
    var name: String?
    var lastName: String?
    var age: Int?
    var gender: String?
    var language: String?
    var country: String?
    var email: String?
    var password: String?
    var id: Int?
    var user: User?
    
    let menager = ModelMenager()
    
    init() {}
    
    init(data: DictionaryType) {
        if
            let email = data[UserAttributes.Email.rawValue] as? String,
            let password = data[UserAttributes.Password.rawValue] as? String,
            let id = data[UserAttributes.Id.rawValue] as? Int {
            
            self.email = email
            self.password = password
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
    
    // MARK: - Private
    private func newEntity() -> User {
        let context = self.menager.getContext()
        let entity = NSEntityDescription.insertNewObject(forEntityName: Entity.User.rawValue, into: context) as! User
        return entity
    }
    
    private func save(model: UserModel) -> (success: Bool, error: String?) {
    
        var result: (success: Bool, error: String?) = (false, nil)
        let entity = self.newEntity()
        
        if let id = model.id, let email = model.email, let password = model.password {
            
            entity.id = NSNumber(value: id)
            entity.email = email
            entity.password = password
            
            if let name = model.name {
                entity.name = name
            }
            if let lastName = model.lastName {
                entity.lastName = lastName
            }
            if let age = model.age {
                entity.age = NSNumber(value: age)
            }
            if let gender = model.gender {
                entity.gender = gender
            }
            if let language = model.language {
                entity.language = language
            }
            if let country = model.country {
                entity.country = country
            }
            
            let save = self.menager.save(context: entity.managedObjectContext)
            
            result = (save.success, save.error)
        }
        
        return result
    }
    
    private func update(model: UserModel, data: [User]) {
        
        for i in 0 ..< data.count {
            
            if let email = model.email {
                data[i].email = email
            }
            if let password = model.password {
                data[i].password = password
            }
            if let name = model.name {
                data[i].name = name
            }
            if let lastName = model.lastName {
                data[i].lastName = lastName
            }
            if let age = model.age {
                data[i].age = NSNumber(value: age)
            }
            if let gender = model.gender {
                data[i].gender = gender
            }
            if let language = model.language {
                data[i].language = language
            }
            if let country = model.country {
                data[i].country = country
            }
            
            let save = self.menager.save(context: data[i].managedObjectContext)
            
            print("update status: \(save.success)")
        }
    }
    
    // MARK: - Public
    func saveFrom(model: UserModel) -> (success: Bool, error: String?) {
        
        var result: (success: Bool, error: String?) = (false, nil)
        
        let predicate = self.menager
        let entityData = self.menager.getData(entity: .User)
        
        func save() {
            let save = self.save(model: model)
            result = (save.success, save.error)
        }
        
        if entityData.data == nil {
            save()
        }else {
            if let data = entityData.data as? [User], let id = model.id {
                let users = data.filter({$0.id == NSNumber(value: id)})
                if users.count > 0 {
                    self.update(model: model, data: users)
                    result = (true, nil)
                }else {save()}
            }else {save()}
        }
        
        return result
    }
    
    func getData() -> (data: [UserModel]?, error: String?) {
        
        let msg: String? = Messages.DataNoFound.rawValue
        var result: (data: [UserModel]?, error: String?) = (nil, nil)
        var item = UserModel()
        var items = [UserModel]()
        
        let data = self.menager.getData(entity: .User)
        
        if let data = data.data as? [User] {
            
            for entity in data {
                
                item.name = entity.name
                item.lastName = entity.lastName
                item.age = Int(entity.age)
                item.gender = entity.gender
                item.language = entity.language
                item.country = entity.country
                item.email = entity.email
                item.password = entity.password
                item.id = Int(entity.id)
                
                items.append(item)
                item = UserModel()
            }
            
            if items.count > 0 {
                result = (items, nil)
            }
        }else {
            result = (nil, msg)
        }
        
        return result
    }
    
    func delete() -> (success: Bool, error: String?) {
        return self.menager.delete(entity: .User)
    }
    
    func getDictionary(model: UserModel) -> DictionaryType? {
        
        var result = DictionaryType()
        
        if let name = model.name {
            result[UserAttributes.Name.rawValue] = name
        }
        if let lastName = model.lastName {
            result[UserAttributes.LastName.rawValue] = lastName
        }
        if let age = model.age {
            result[UserAttributes.Age.rawValue] = age
        }
        if let gender = model.gender {
            result[UserAttributes.Gender.rawValue] = gender
        }
        if let language = model.language {
            result[UserAttributes.Language.rawValue] = language
        }
        if let country = model.country {
            result[UserAttributes.Country.rawValue] = country
        }
        if let email = model.email {
            result[UserAttributes.Email.rawValue] = email
        }
        if let password = model.password {
            result[UserAttributes.Password.rawValue] = password
        }
        if let id = model.id {
            result[UserAttributes.Id.rawValue] = id
        }
        
        if result.isEmpty {
            return nil
        }
        
        return result
    }
    
    func getDictionaryFormatedKeys(model: UserModel) -> DictionaryType? {
        
        var result = DictionaryType()
        
        if let name = model.name, let lastName = model.lastName {
            result[UserKeys.Name.rawValue] = "\(name) \(lastName)"
        }
        if let age = model.age {
            result[UserKeys.Age.rawValue] = age
        }
        if let gender = model.gender {
            result[UserKeys.Gender.rawValue] = gender
        }
        if let language = model.language {
            result[UserKeys.Language.rawValue] = language
        }
        if let country = model.country {
            result[UserKeys.Country.rawValue] = country
        }
        if let email = model.email {
            result[UserKeys.Email.rawValue] = email
        }
        if let password = model.password {
            result[UserKeys.Password.rawValue] = password
        }
        if let id = model.id {
            result[UserKeys.Id.rawValue] = id
        }
        
        if result.isEmpty {
            return nil
        }
        
        return result
    }
    
}
