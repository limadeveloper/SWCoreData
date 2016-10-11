//
//  UserViewController.swift
//  SWCoreData
//
//  Created by John Lima on 25/09/16.
//  Copyright © 2016 John Lima. All rights reserved.
//

import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Properties
    @IBOutlet weak var table: UITableView!
    
    private let global = Global()
    private let userModel = UserModel()
    private let appDelegate = App.delegate as? AppDelegate
    private let cellIdentifier = "cell"
    private var keys = [String]()
    private var values = [Any]()
    
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
        self.appDelegate?.startController()
    }
    
    private func updateUI() {
        
        if let user = user, let dictionaryUser = self.userModel.getDictionaryFormatedKeys(model: user) {
            self.keys = Array(dictionaryUser.keys)
            self.values = Array(dictionaryUser.values)
        }
    }

    // MARK: - TableView DataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.keys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        cell.textLabel?.text = "\(self.values[indexPath.row])"
        cell.detailTextLabel?.text = self.keys[indexPath.row]
        
        return cell
    }
    
    // MARK: - TableView Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
