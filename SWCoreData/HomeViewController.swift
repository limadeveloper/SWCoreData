//
//  HomeViewController.swift
//  SWCoreData
//
//  Created by John Lima on 19/09/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    // MARK: - Properties
    private let user = UserModel()
    
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
        
        let user = self.user.getData()
        print("Number of users: \(user.data?.count)")
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
}
