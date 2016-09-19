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
    
}
