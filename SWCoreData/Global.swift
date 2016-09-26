//
//  Global.swift
//  SWCoreData
//
//  Created by John Lima on 18/09/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

let App = UIApplication.shared

class Global {
    
    func save(bool: Bool, key: Key) {
        UserDefaults.standard.set(bool, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func save(int: Int, key: Key) {
        UserDefaults.standard.set(int, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getBool(key: Key) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    func getInt(key: Key) -> Int? {
        return UserDefaults.standard.integer(forKey: key.rawValue)
    }
    
    func delete(key: Key) {
        UserDefaults.standard.removeObject(forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func dismissKeyboard(fields: [UITextField]) {
        if fields.count > 0 {
            for field in fields {
                field.resignFirstResponder()
            }
        }
    }
    
    func getLocalJsonData(name: JsonName) -> (json: ArrayType?, error: String?) {
        var result: (json: ArrayType?, error: String?) = (nil, nil)
        if let path = Bundle.main.path(forResource: name.rawValue, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? ArrayType
                result = (json, nil)
            }catch let error {
                result = (nil, error.localizedDescription)
            }
        }else {
            print("Invalid filename/path.")
        }
        return result
    }
    
    func getUserWith(email: String, password: String) -> (user: DictionaryType?, error: String?) {
        
        var result: (user: DictionaryType?, error: String?) = (nil, nil)
        let user = self.getLocalJsonData(name: .User)
        
        if user.json != nil, let json = user.json {
            let json = json.filter({$0[UserAttributes.Email.rawValue] as? String == email.lowercased() && $0[UserAttributes.Password.rawValue] as? String == password}).first
            result = (json, nil)
        }else {
            result = (nil, user.error)
        }
        
        return result
    }
    
    func createAlert(title: String?, message: String, actions: [UIAlertAction], target: AnyObject?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        if actions.count > 0 {
            for action in actions {
                alert.addAction(action)
            }
        }
        target?.present(alert, animated: true, completion: nil)
    }
    
    func isValidEmail(email: String?) -> Bool {
        if email?.range(of: "@") != nil && email?.range(of: ".com") != nil {
            return true
        }
        return false
    }
    
    func deleteDatabase() -> (success: Bool, error: String?) {
        let user = UserModel()
        return user.delete()
    }
    
}
