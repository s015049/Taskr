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
        let membersArr = membersString.components(separatedBy: ",") as NSArray
        let groups: NSArray = [name.text!]
        let taskArr: NSArray = [Task(description: "do stuff", person: "Billy", dueDate: "4/3/20").toString()]

        ref.child("groups").child(name.text!).setValue(["tasks": taskArr, "members": membersArr])

        // adds group to user's list of groups by iterating thourgh all members
        for m in membersArr {
            ref.child("users").child(m as! String).child("groups").setValue(groups)
        } // end of for-loop

        self.dismiss(animated: true, completion: nil)
        print("Group \(name.text!) added")
        
        // reads in current arr of user's groups; this a test of updating
        ref.child("users").child(Auth.auth().currentUser!.displayName!).child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
          // Get user value
          // when trying to read from a blacnk database, snapshot.value = NSNull object; use this for optional binding
          var value = snapshot.value as! NSArray as AnyObject as! [String]
          print("value: \(value)")
          value.append("eh")
          print("value: \(value)")
          ref.child("users").child(Auth.auth().currentUser!.displayName!).child("groups").setValue(value)

          // ...
          }) { (error) in
            print(error.localizedDescription)
        }
        
        
    } // end of addGroup
    
}
