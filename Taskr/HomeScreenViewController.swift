//  HomeScreenViewController.swift
//  Taskr
//  Created by Maxwell Serota (student LM) on 2/23/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import UIKit

class homeScreenCell : UITableViewCell, UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "group", for: indexPath) as! homeScreenCell
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    @IBOutlet weak var groupNameLabel: UILabel!
    var ref: DatabaseReference! = Database.database().reference()
    var taskArray : [String] = []
    @IBOutlet weak var taskTableView: UITableView!
    
}

class groupCell : UITableViewCell{
    @IBOutlet weak var taskNameLabel : UILabel!
    @IBOutlet weak var taskDescriptionLabel : UILabel!
    @IBOutlet weak var isCompleteButton : UIButton!
    var ref: DatabaseReference! = Database.database().reference()
    
}

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var ref: DatabaseReference!
    var groupArray : [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return groupArray.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        ref = Database.database().reference()
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeScreen", for: indexPath) as! homeScreenCell
        cell.groupNameLabel.text = groupArray[indexPath.row]
        cell.groupNameLabel.font = UIFont(name: "avenir next demi bold", size: 35)
        
        return cell
    } 
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("users").child(Auth.auth().currentUser!.displayName!).child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
            if  var value = snapshot.value as! NSArray as AnyObject as? [String] {
                self.groupArray = value
            }
        }) { (error) in
            print(error.localizedDescription)
        }
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
