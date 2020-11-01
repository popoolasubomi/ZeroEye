//
//  LoginViewController.swift
//  ZeroEye
//
//  Created by Subomi Popoola on 10/31/20.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setFrames()
    }
    
    func loginUser() {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!) { (success, error) in
            if (success != nil) {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            } else{
                print("Coudlnt log in")
            }
        }
    }
    
    func setFrames() {
        let viewFrame = self.view.frame
        
        self.chatLabel.frame.origin.x = (viewFrame.size.width - self.chatLabel.frame.size.width) / 2
        self.chatLabel.frame.origin.y = (viewFrame.size.height * 0.15)
        
        self.usernameField.frame.origin.x = 35
        self.usernameField.frame.origin.y = viewFrame.size.height * 0.35
        self.usernameField.frame.size.width = viewFrame.size.width - 70
        
        self.passwordField.frame.origin.x = 35
        self.passwordField.frame.origin.y = viewFrame.size.height * 0.60
        self.passwordField.frame.size.width = viewFrame.size.width - 70
        
        self.loginButton.frame.origin.x = (viewFrame.size.width - self.loginButton.frame.size.width) / 2
        self.loginButton.frame.origin.y = (viewFrame.size.height * 0.85)
    }
    
    @IBAction func onLogin(_ sender: Any) {
        loginUser()
    }
    
    @IBAction func onTap(_ sender: Any) {
        self.view.endEditing(true)
    }
}
