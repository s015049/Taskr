//
//  SignUpViewController.swift
//  Taskr
//
//  Created by Jack Shapiro (student LM) on 2/22/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var emailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameTextField.delegate = self
        emailAddressTextField.delegate = self
        passwordTextField.delegate = self
        usernameTextField.becomeFirstResponder()
        signUpButtonOutlet.isEnabled = false

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if usernameTextField.isFirstResponder {
            emailAddressTextField.becomeFirstResponder()
        }
        else if emailAddressTextField.isFirstResponder {
            passwordTextField.becomeFirstResponder()
        }
        else {
            passwordTextField.resignFirstResponder()
            signUpButtonOutlet.isEnabled = true // enables sign-up button once all fields are filled
        }
        return true
    }
    
    @IBAction func signUpButtonClicked(_ sender: UIButton) {
         guard let userName = usernameTextField.text else {return}
         guard let email = emailAddressTextField.text else {return}
         guard let password = passwordTextField.text else {return}
        
         Auth.auth().createUser(withEmail: email, password: password){user, error in
             if let _ = user {
                 let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
                 changeRequest?.displayName = userName
                 changeRequest?.commitChanges(completion: {(error) in print("this is an error but the display name change still works for some reason")})
                 self.dismiss(animated: true, completion: nil) // end of completion handler
             }
             else {
                 print(error.debugDescription)
             }
         } // end of auth method
        
        // more work is needed for this
        let ref: DatabaseReference!  = Database.database().reference()
        ref.child("users").child(userName).child("groups").setValue(NSArray(array: ["test"])) // this works because the array has data
        ref.child("users").child(userName).child("tasks").setValue(NSArray(array: [])) // this doesn't because the array is empty
    }
    
    

}
