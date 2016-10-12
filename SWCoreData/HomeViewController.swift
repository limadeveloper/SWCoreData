//
//  HomeViewController.swift
//  SWCoreData
//
//  Created by John Lima on 19/09/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    private var user = UserModel()
    private let global = Global()
    
    // MARK: - View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.getData()
    }
    
    // MARK: - Actions
    @IBAction func showUser() {
        self.performSegue(withIdentifier: Segue.User.rawValue, sender: nil)
    }
    
    private func getData() {
        
        if
            let userId = self.global.getInt(key: .User),
            let userData = self.user.getData(param1: (userId, UserAttributes.Id.rawValue, .Equal)).data?.first {
            
            self.user = userData
        }
        
        print("User: \(self.user.name)")
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier! {
        case Segue.User.rawValue:
            let controller = segue.destination as! UserViewController
            controller.user = self.user
        default:
            break
        }
    }
    
}
