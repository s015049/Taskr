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
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var members: UITextField!
    @IBOutlet weak var addGroupButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
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
    
    // please commmiT
    
    @IBAction func addGroup(_ sender: UIButton) { // ADD OPTIONAL BINDING!
        let ref: DatabaseReference!  = Database.database().reference()
    
        // adds group to master list of groups
        let membersString = "\(members.text!),\(Auth.auth().currentUser!.displayName!)"
        let membersArr: NSArray = membersString.components(separatedBy: ",") as NSArray
        let groups: [String] = [name.text!]
        let taskArr: NSArray = [Task(description: "do stuff", person: "Billy", dueDate: Date())]

        ref.child("groups").child(name.text!).setValue(["tasks": taskArr, "members": membersArr])

        // adds group to user's list of groups by iterating thourgh all members
        for m in membersArr {
            ref.child("users").child(m as! String).child("groups").setValue(groups)
        } // end of for-loop

        self.dismiss(animated: true, completion: nil)
        print("Group \(name.text!) added")
    } // end of addGroup
    
}
