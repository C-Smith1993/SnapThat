//
//  SignInViewController.swift
//  SnapThat
//
//  Created by Chris Smith on 07/03/2017.
//  Copyright © 2017 CDSApps. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class SignInViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func signInTapped(_ sender: Any) {
     
        FIRAuth.auth()?.signIn(withEmail: emailTextField.text!, password: passwordTextField.text!, completion: { (user, error) in
            print("We tried to sign in")
            if error != nil {
                print("We have an error: \(error)")
                
                FIRAuth.auth()?.createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!, completion: { (user, error) in
                    print("We tried to create a user")
                    
                    if error != nil {
                        print("We have an error: \(error)")
                    } else {
                        print("Created user successfully")
                        self.performSegue(withIdentifier: "signInSegue", sender: nil)
                    }
                })
                
            } else {
                print("Signed in succesfully")
                self.performSegue(withIdentifier: "signInSegue", sender: nil)
            }
        })
    }
}












