//
//  GroupCreatorViewController.swift
//  Taskr
//
//  Created by Jack Shapiro (student LM) on 2/21/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
//

import UIKit
import Firebase

class GroupCreatorViewController: UIViewController, UITextFieldDelegate {
    
    var ref: DatabaseReference!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var members: UITextField!
    @IBOutlet weak var addGroupButtonOutlet: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure()
        ref = Database.database().reference()
        
        name.delegate = self
        members.delegate = self
        name.becomeFirstResponder()
        addGroupButtonOutlet.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if name.isFirstResponder {
            members.becomeFirstResponder()
        }
        else {
            members.resignFirstResponder()
            addGroupButtonOutlet.isEnabled = true // enables add group in button once all fields are filled
        }
        return true
    }
    
    // commit engine please see me please 2.2
    
    @IBAction func addGroup(_ sender: UIButton) {
        // adds group to master list of groups
            /* commented this part out so it could run, there was an error with the newGroup call
             ref.child("groups").child(newGroup.name).setValue(["tasks": [], "members": [Auth.auth().currentUser?.uid]])
             
            // adds group to user's list of groups
             ref.child("users").child(Auth.auth().currentUser?.uid).child("groups").setValue(newGroup.name) */
    }
    
}
