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
    var user: [UserModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateUI()
    }
    
    private func updateUI() {
        
        if let user = user {
            print("User: \(user)")
        }else {
            print("User no found")
        }
    }

}
