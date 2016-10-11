//
//  LoginViewController.swift
//  SWCoreData
//
//  Created by John Lima on 15/09/16.
//  Copyright © 2016 limadeveloper. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {

    // MARK: Properties
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    private let global = Global()
    private let appDelegate = App.delegate as? AppDelegate
    
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
        
        self.loginField.text = "limadeveloper@apple.com"
        self.passwordField.text = "12345678"
    }
    
    private func login() {
        
        self.global.dismissKeyboard(fields: [self.loginField, self.passwordField])
        
        let actionError = UIAlertAction(title: Messages.Ok.rawValue, style: .destructive, handler: nil)
        
        let email = self.loginField.text?.replacingOccurrences(of: " ", with: "").lowercased()
        let password = self.passwordField.text?.replacingOccurrences(of: " ", with: "")
        
        if email != "" && password != "" && self.global.isValidEmail(email: email), let email = email, let password = password {
            let user = self.global.getUserWith(email: email, password: password)
            if let user = user.user {
                let model = UserModel(data: user)
                let save = model.saveFrom(model: model)
                if save.success, let id = model.id {
                    let actionOk = UIAlertAction(title: Messages.Ok.rawValue, style: .default) { [weak self] (action) in
                        self?.global.save(int: id, key: .User)
                        self?.global.save(bool: true, key: .Login)
                        self?.appDelegate?.startController()
                    }
                    DispatchQueue.main.async {
                        self.global.createAlert(title: Messages.Success.rawValue, message: Messages.Saved.rawValue, actions: [actionOk], target: self)
                    }
                }else {
                    let error = save.error != nil ? "Erro: \(save.error!)" : Messages.SaveError.rawValue
                    DispatchQueue.main.async {
                        self.global.createAlert(title: Messages.Alert.rawValue, message: error, actions: [actionError], target: self)
                    }
                }
            }else {
                let error = Messages.CheckFields.rawValue
                DispatchQueue.main.async {
                    self.global.createAlert(title: Messages.Alert.rawValue, message: error, actions: [actionError], target: self)
                }
            }
        }else {
            DispatchQueue.main.async {
                self.global.createAlert(title: Messages.Alert.rawValue, message: Messages.CheckFields.rawValue, actions: [actionError], target: self)
            }
        }
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

