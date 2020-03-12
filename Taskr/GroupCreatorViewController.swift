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
        
        ref.child("groups").child(self.name.text!).setValue(["tasks": taskArr, "members": membersArr])
        
        // adds group to members branch
        for member in membersArr {
            ref.child("users").child(member as! String).child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
                if let _ = snapshot.value as? NSNull { // if user has no prior groups
                    // adds group to user's list of groups by iterating thourgh all members
                    ref.child("users").child(member as! String).child("groups").setValue(groups)
                }
                else { // if user has prior groups
                    var value = snapshot.value as! NSArray as AnyObject as! [String]
                    value.append(self.name.text!)
                    ref.child("users").child(member as! String).child("groups").setValue(value)
                }

              }) { (error) in
                print(error.localizedDescription)
            } // end of read method
        }
        
        self.dismiss(animated: true, completion: nil)
        
        
        
    } // end of addGroup
    
}
