//  HomeScreenViewController.swift
//  Taskr
//  Created by Maxwell Serota (student LM) on 2/23/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var groupsArray : [String]?
//    @IBOutlet weak var tableView: UITableView! {
//        didSet {
//            self.tableView.delegate = self
//            self.tableView.dataSource = self
//        }
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // sets groupsArray to all of user's groups
//        ref.child("users").child(Auth.auth().currentUser!.displayName!).child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
//            if let _ = snapshot.value as? NSNull { // if user has no prior groups
//                self.groupsArray = []
//            }
//            else { // if user has prior groups
//                self.groupsArray = snapshot.value as! NSArray as AnyObject as! [String] // reads in current groups
//            }
//          }) { (error) in
//            print(error.localizedDescription)
//        } // end of read method
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let ref: DatabaseReference! = Database.database().reference()
        print("hey, vSauce, Michael here")
        ref.child("users").child(Auth.auth().currentUser!.displayName!).child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull { // if user has no prior groups
                self.groupsArray = []
            }
            else { // if user has prior groups
                self.groupsArray = snapshot.value as! NSArray as AnyObject as! [String] // reads in current groups
                print("prior groups exist")
                for s in self.groupsArray! {
                    print("item in groupsArray: \(s)")
                }
            }
          }) {
            (error) in
            print(error.localizedDescription)
        } // end of read method

        // maybe should have -1
//        dump(groupsArray)
//        print("groupsArray.count: \(groupsArray!.count)")
//        return groupsArray!.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeScreen", for: indexPath) as! homeScreenCell
        cell.groupNameLabel.text = groupsArray![indexPath.row]
        print("groupsArray at indexPath.row: \(groupsArray![indexPath.row])")
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? homeScreenCell {
            if let groupViewController = segue.destination as? GroupViewController {
                // add database read function
                // webViewController.url = cell.url this line is from the JSON project
                // groupViewController.name = name of group
                // groupViewController.tasks = array fo tasks from database
            }
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

class homeScreenCell : UITableViewCell{
    @IBOutlet weak var groupNameLabel: UILabel!
}

