//
//  LoginViewController.swift
//  SWCoreData
//
//  Created by John Lima on 15/09/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private let global = Global()
    
    // MARK: View LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.updateUI()
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.global.dismissKeyboard(fields: [self.loginField, self.passwordField])
    }
    
    // MARK: Actions
    private func updateUI() {
        
        self.loginField.delegate = self
        self.passwordField.delegate = self
        
        let user = self.global.getLocalJsonData(name: .User)
        
        if user.json != nil, let json = user.json {
            print("json: \(json)")
        }else {
            print("error: \(user.error)")
        }
    }
    
    private func login() {
        
        self.global.dismissKeyboard(fields: [self.loginField, self.passwordField])
    }
    
    // MARK: TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if self.loginField.isFirstResponder {
            self.passwordField.becomeFirstResponder()
        }else {
            self.login()
        }
        return true
    }
    
}

