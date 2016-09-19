//
//  UserModel.swift
//  SWCoreData
//
//  Created by John Lima on 15/09/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
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
    
    init(data: Dictionary<UserAttributes,Any>) {
        if
            let email = data[.Email] as? String,
            let password = data[.Password] as? String,
            let id = data[.Id] as? Int {
            
            self.email = email
            self.password = password
            self.id = id
            
            if let name = data[.Name] as? String {
                self.name = name
            }
            if let lastName = data[.LastName] as? String {
                self.lastName = lastName
            }
            if let age = data[.Age] as? Int {
                self.age = age
            }
            if let gender = data[.Gender] as? String {
                self.gender = gender
            }
            if let language = data[.Language] as? String {
                self.language = language
            }
            if let country = data[.Country] as? String {
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
    
    func getDictionary(model: UserModel) -> Dictionary<UserAttributes,Any>? {
        
        var result = Dictionary<UserAttributes,Any>()
        
        if let name = model.name {
            result[.Name] = name
        }
        if let lastName = model.lastName {
            result[.LastName] = lastName
        }
        if let age = model.age {
            result[.Age] = age
        }
        if let gender = model.gender {
            result[.Gender] = gender
        }
        if let language = model.language {
            result[.Language] = language
        }
        if let country = model.country {
            result[.Country] = country
        }
        if let email = model.email {
            result[.Email] = email
        }
        if let password = model.password {
            result[.Password] = password
        }
        if let id = model.id {
            result[.Id] = id
        }
        
        if result.isEmpty {
            return nil
        }
        
        return result
    }
    
}
