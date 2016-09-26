//
//  UserViewController.swift
//  SWCoreData
//
//  Created by John Lima on 25/09/16.
//  Copyright © 2016 John Lima. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    // MARK: - Properties
    private let global = Global()
    
    var user: UserModel?
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateUI()
    }
    
    // MARK: - Actions
    @IBAction func logout() {
        self.global.save(bool: false, key: .Login)
        self.global.delete(key: .User)
        self.global.setupInitialViewController()
    }
    
    private func updateUI() {
        
        if let user = user {
            print("User: \(user.name)")
        }else {
            print("User no found")
        }
    }

    
}
