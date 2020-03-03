//
//  HomeScreenViewController.swift
//  Taskr
// suck my dick
//  Created by Maxwell Serota (student LM) on 2/23/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
//
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import UIKit

class homeScreenCell : UITableViewCell{
    @IBOutlet weak var groupNameLabel : UILabel!
    @IBOutlet weak var taskTableView : UITableView!
    var ref: DatabaseReference! = Database.database().reference()
 // things
}

class groupCell : UITableViewCell{
    @IBOutlet weak var taskNameLabel : UILabel!
    @IBOutlet weak var taskDescriptionLabel : UILabel!
    @IBOutlet weak var isCompleteButton : UIButton!
    var ref: DatabaseReference! = Database.database().reference()

}

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var ref: DatabaseReference!
    var groupArray : [Group] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ref = Database.database().reference()
        let email = Auth.auth().currentUser!.email!
        ref.child("users").child(email).child("groups").observe(.value) { (snapshot) in
       
            self.groupArray = snapshot.value as? NSArray as! [Group]
         }
        return groupArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    
    @IBAction func logOutButtonPressed(_ sender: Any) {
            let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            print("logged out")
            self.dismiss(animated: true, completion: nil)
        } catch let signOutError as NSError {
          print ("Error signing out: %@", signOutError)
        }
          
    }
    
    
    

}
