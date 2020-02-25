//
//  GroupCreatorViewController.swift
//  Taskr
//
//  Created by Jack Shapiro (student LM) on 2/21/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
//

import UIKit
import Firebase

class GroupCreatorViewController: UIViewController {
    
    var ref: DatabaseReference!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        FirebaseApp.configure()
        // below prob not needed
        ref = Database.database().reference()
    }
    // commit engine please see me please 2.1
    func createGroup() {
        // adds group to master list of groups
        /* commented this part out so it could run, there was an error with the newGroup call
         ref.child("groups").child(newGroup.name).setValue(["tasks": [], "members": [Auth.auth().currentUser?.uid]])
         
        // adds group to user's list of groups
         ref.child("users").child(Auth.auth().currentUser?.uid).child("groups").setValue(newGroup.name) */
    }

    

}
