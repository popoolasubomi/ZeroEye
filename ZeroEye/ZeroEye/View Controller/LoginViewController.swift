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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onLogin(_ sender: Any) {
        self.performSegue(withIdentifier: "loginSegue", sender: nil)
    }
    
}
