//
//  AppDelegate.swift
//  SWCoreData
//
//  Created by John Lima on 15/09/16.
//  Copyright © 2016 John Lima. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let modelMenager = ModelMenager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.modelMenager.saveContext()
    }

}

