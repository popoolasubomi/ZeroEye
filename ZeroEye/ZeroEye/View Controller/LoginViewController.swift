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
    
    @IBAction func onLogin(_ sender: Any) {
        loginUser()
    }
    
}
