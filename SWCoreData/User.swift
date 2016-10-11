//
//  User.swift
//  SWCoreData
//
//  Created by John Lima on 15/09/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import CoreData

@objc(User)

class User: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var lastName: String
    @NSManaged var age: NSNumber
    @NSManaged var gender: String
    @NSManaged var language: String
    @NSManaged var country: String
    @NSManaged var email: String
    @NSManaged var password: String
    @NSManaged var id: NSNumber
}
