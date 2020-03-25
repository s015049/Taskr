//
//  addTaskViewController.swift
//  Taskr
//
//  Created by Alex Gerstein (student LM) on 2/27/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.

import UIKit
import Firebase

class addTaskViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var assignedToTextField: UITextField!
    @IBOutlet weak var groupNameTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextField.delegate = self
        dueDateTextField.delegate = self
        assignedToTextField.delegate = self
        descriptionTextField.becomeFirstResponder()
        groupNameTextField.delegate = self
        addTaskButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if descriptionTextField.isFirstResponder {
            dueDateTextField.becomeFirstResponder()
        }
        else if dueDateTextField.isFirstResponder {
            assignedToTextField.becomeFirstResponder()
        }
        else if assignedToTextField.isFirstResponder {
            groupNameTextField.becomeFirstResponder()
        }
        else {
            groupNameTextField.resignFirstResponder()
            addTaskButton.isEnabled = true
        }
        return true
    }
    
    @IBAction func addTaskButtonClicked(_ sender: UIButton) {
      
        let ref: DatabaseReference!  = Database.database().reference()
        
        let description = descriptionTextField.text!
        let dueDate = dueDateTextField.text!
        let assignedToString = assignedToTextField.text! // list of all those to whom the task is assigned
        let assignedToArray = assignedToTextField.text!.components(separatedBy: ",") as NSArray
        let groupName = groupNameTextField.text!
        let newTask = Task(description: description, person: assignedToString, dueDate: dueDate, groupName: groupName).toString()
        
        // adds task to groups branch
        ref.child("groups").child(groupName).child("tasks").observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull { // if group has no prior tasks
                // adds task to group
                ref.child("groups").child(groupName).child("tasks").setValue([newTask])
            }
            else { // if group has prior tasks
                var value = snapshot.value as! NSArray as AnyObject as! [String] // reads in current groups
                value.append(newTask) // adds new task to end of tasks array
                ref.child("groups").child(groupName).child("tasks").setValue(value) // uploads updated tasks array
            }

        }) { (error) in
            print(error.localizedDescription)
        } // end of read method
        
        // adds task to users branch
        for user in assignedToArray {
            ref.child("users").child(user as! String).child("tasks").observeSingleEvent(of: .value, with: { (snapshot) in
                if let _ = snapshot.value as? NSNull { // if user has no prior tasks
                    // adds task to user's list of tasks by iterating thourgh all members
                    ref.child("users").child(user as! String).child("tasks").setValue([newTask])
                }
                else { // if user has prior tasks
                    var value = snapshot.value as! NSArray as AnyObject as! [String] // reads in current groups
                    value.append(newTask) // adds new task to end of tasks array
                    ref.child("users").child(user as! String).child("tasks").setValue(value) // uploads updated tasks array
                }

            }) { (error) in
                print(error.localizedDescription)
            } // end of read method
        } // end of for-loop
        
    }
}
