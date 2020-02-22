//
//  LoginViewController.swift
//  Taskr
//
//  Created by Jack Shapiro (student LM) on 2/22/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        emailAddressTextField.becomeFirstResponder()
        logInButtonOutlet.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if emailAddressTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }
        else {
            passwordTextField.resignFirstResponder()
            logInButtonOutlet.isEnabled = true // enables log in button once all fields are filled
        }
        return true
    }
    
    
    @IBAction func logInButtonClicked(_ sender: UIButton) {
        guard let email = emailAddressTextField.text else {return}
        guard let password = passwordTextField.text else {return}
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if let _ = user {
                self.dismiss(animated: true, completion: nil)
                print("Signed in!")
            }
            else {
                print(error!.localizedDescription)
            }
        } // end of auth method
    }
    
}
