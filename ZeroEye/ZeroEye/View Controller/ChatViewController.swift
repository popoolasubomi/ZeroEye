//
//  ChatViewController.swift
//  ZeroEye
//
//  Created by Subomi Popoola on 10/31/20.
//

import UIKit
import Parse
import MessageInputBar

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
   
    
    @IBOutlet weak var encryptSwitch: UISwitch!
    @IBOutlet weak var tableView: UITableView!
    
    var messages = [PFObject]()
    var messageBar = MessageInputBar()
    var showMessageBar = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        populateTable()
        
        Timer.scheduledTimer(timeInterval: 3,
                             target: self,
                             selector: #selector(self.populateTable),
                             userInfo: nil,
                             repeats: true)
        
        self.messageBar.inputTextView.placeholder = "iMessage"
        self.messageBar.sendButton.title = "Send"
        self.messageBar.delegate = self
        
        self.tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc func keyboardWillBeHidden(note: Notification){
             messageBar.inputTextView.text = nil
             showMessageBar = true
             becomeFirstResponder()
        }
    
    override var inputAccessoryView: UIView?{
           return messageBar
       }
       
    override var canBecomeFirstResponder: Bool{
       return showMessageBar
      }
    
    @objc func populateTable() {
        let query = PFQuery(className:"Chats")
        query.includeKey("author")
        query.order(byAscending: "createdAt")
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
        
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let chat = PFObject(className: "Chats")
        let encryptedTexts = Cryptograph.sharedInstance.encryptText(text: text)
        chat["Chats"] = encryptedTexts
        chat["author"] = PFUser.current()!
        chat.saveInBackground { (success, error) in
            if (error == nil) {
                self.messageBar.inputTextView.text = nil
                self.populateTable()
            } else {
                print("Couldn't send message!")
            }
        }
        
    }
    
    @IBAction func switchMoved(_ sender: Any) {
        populateTable()
    }
    
    @IBAction func onLogout(_ sender: Any) {
        PFUser.logOutInBackground { (error) in
            if (error == nil) {
                print("Successful logout")
                let main = UIStoryboard(name: "Main", bundle: nil)
                let loginViewController = main.instantiateViewController(identifier: "loginViewController")
                let sceneDelegate = self.view.window?.windowScene?.delegate as! SceneDelegate
                sceneDelegate.window?.rootViewController = loginViewController
            } else {
                print("Failed to Logout")
            }
        }
    }
    
}
