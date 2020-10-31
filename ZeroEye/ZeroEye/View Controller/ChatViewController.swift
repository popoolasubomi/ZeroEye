//
//  ChatViewController.swift
//  ZeroEye
//
//  Created by Subomi Popoola on 10/31/20.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var encryptSwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    var messages = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        Timer.scheduledTimer(timeInterval: 3,
                             target: self,
                             selector: #selector(self.populateTable),
                             userInfo: nil,
                             repeats: true)
    }

    @objc func populateTable() {
        let query = PFQuery(className:"Chats")
        query.includeKey("author")
        query.order(byDescending: "createdAt")
        query.findObjectsInBackground { (objects, error) in
            if (error == nil) {
                self.messages = objects!
                self.tableView.reloadData()
            } else {
                print("Coudln't load messages")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        cell.isEncrypted = self.encryptSwitch.isOn
        cell.setChatCell(message: self.messages[indexPath.row])
        return cell
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if (error == nil) {
                self.dismiss(animated: true, completion: nil)
            } else {
                print("Failed to Logout")
            }
        }
    }
    
}
