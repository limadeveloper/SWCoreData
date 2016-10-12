//
//  ModelMenager.swift
//  SWCoreData
//
//  Created by John Lima on 15/09/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import CoreData

enum Entity: String {
    case User = "User"
}

enum PredicateType: String {
    case Equal = "=="
    case Different = "<>"
    case AND = "AND"
}

class ModelMenager {

    private let storeName = "Model"
    
    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
         */
        let container = NSPersistentContainer(name: self.storeName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    func saveContext () {
        let context = self.getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func getContext() -> NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func save(context: NSManagedObjectContext?) -> (success: Bool, error: String?) {
        
        var result: (success: Bool, error: String?) = (false, nil)
        
        do {
            try context?.save()
            result = (true, nil)
        }catch {
            result = (false, "\(error)")
        }
        
        return result
    }
    
    func getData(entity: Entity, predicate: NSPredicate? = nil) -> (data: [Any]?, error: String?) {
        
        var result: (data: [Any]?, error: String?) = (nil, nil)
        let context = self.getContext()
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity.rawValue)
        
        fetchRequest.predicate = predicate
        
        do {
            let results = try context.fetch(fetchRequest)
            result = (results, nil)
        }catch let error {
            result = (nil, error.localizedDescription)
        }
        
        return result
    }
    
    func delete(entity: Entity) -> (success: Bool, error: String?) {
        
        var result: (success: Bool, error: String?) = (false, nil)
        let context = self.getContext()
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entity.rawValue)
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            result = (true, nil)
        }catch let error {
            result = (false, error.localizedDescription)
        }
        
        return result
    }
    
    func getPredicate(id: Int?, key: String, type: PredicateType) -> NSPredicate? {
        if let id = id {
            return NSPredicate(format: "\(key) \(type.rawValue) %d", id)
        }
        return nil
    }
    
    func getPredicate(value: String?, key: String, type: PredicateType) -> NSPredicate? {
        if let value = value {
            return NSPredicate(format: "\(key) \(type.rawValue) %@", value)
        }
        return nil
    }
    
}
