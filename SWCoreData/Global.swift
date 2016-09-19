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
    
    func saveBool(value: Bool, key: Key) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func getBool(key: Key) -> Bool {
        return UserDefaults.standard.bool(forKey: key.rawValue)
    }
    
    func setupInitialViewController() {
        
        let appDelegate = App.delegate as? AppDelegate
        let window = appDelegate?.window
        
        if self.getBool(key: .Login) {
            self.startController(named: .Home, window: window)
        }else {
            self.startController(named: .Login, window: window)
        }
    }
    
    func startController(named: Identity, window: UIWindow?) {
        let storyboard = UIStoryboard(name: UI.Main.rawValue, bundle: Bundle.main)
        let controller = storyboard.instantiateViewController(withIdentifier: named.rawValue)
        window?.rootViewController = controller
    }
    
    func dismissKeyboard(fields: [UITextField]) {
        if fields.count > 0 {
            for field in fields {
                field.resignFirstResponder()
            }
        }
    }
    
    func getLocalJsonData(name: JsonName) -> (json: DictionaryType?, error: String?) {
        var result: (json: DictionaryType?, error: String?) = (nil, nil)
        if let path = Bundle.main.path(forResource: name.rawValue, ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? DictionaryType
                result = (json, nil)
            }catch let error {
                result = (nil, error.localizedDescription)
            }
        }else {
            print("Invalid filename/path.")
        }
        return result
    }
    
}
