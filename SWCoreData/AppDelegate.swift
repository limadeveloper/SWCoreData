//
//  AppDelegate.swift
//  SWCoreData
//
//  Created by John Lima on 15/09/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let modelMenager = ModelMenager()
    let global = Global()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.startController()
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.modelMenager.saveContext()
    }
    
    func startController() {
        
        let storyboard = UIStoryboard(name: UI.Main.rawValue, bundle: .main)
        let controller: UIViewController?
        
        let login = self.global.getBool(key: .Login)
        
        if login != true {
            controller = storyboard.instantiateViewController(withIdentifier: Identity.Login.rawValue)
        }else {
            controller = storyboard.instantiateViewController(withIdentifier: Identity.Home.rawValue)
        }
        
        self.window?.rootViewController = controller
    }
}

