//  HomeScreenViewController.swift
//  Taskr
//  Created by Maxwell Serota (student LM) on 2/23/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import UIKit

class homeScreenCell : UITableViewCell{
    @IBOutlet weak var groupNameLabel: UILabel!
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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        ref.child("users").child(Auth.auth().currentUser!.displayName!).child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
//              commmented out due to SIGABERT
//            if var value = snapshot.value as! NSArray as AnyObject as? [String] {
//                self.groupArray = value
//            }
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
