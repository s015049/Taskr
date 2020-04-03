//
//  GroupViewController.swift
//  Taskr
//
//  Created by Jack Shapiro (student LM) on 3/25/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class GroupViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var groupNameLabel: UILabel!
    var groupName : String = ""
   var homeScreenViewController : HomeScreenViewController = HomeScreenViewController()
    
    override func viewDidLoad() {
        groupNameLabel.text! = groupName
        super.viewDidLoad()
    }
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        homeScreenViewController.groupTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func getTasks(){
        let ref: DatabaseReference! = Database.database().reference()
        ref.child("groups").child(groupName).child("tasks").observeSingleEvent(of: .value, with: { (snapshot) in
        if let _ = snapshot.value as? NSNull { // if user has no prior groups
            do { // will print true or false
                print("no prior taks")
                try print(JSONSerialization.writeJSON(jsonObject: [] as! [String], toFilename: "tasks"))
            }
            catch {
                print("Failed to write blank groups array")
            }
        }
        else { // if user has prior groups
            do { // will print true or false
                print("yes prior groups")
                try print(JSONSerialization.writeJSON(jsonObject: snapshot.value as! NSArray as AnyObject as! [String], toFilename: "tasks"))
             }
             catch {
                 print("Failed to write filled groups array")
             }
        }
          }) {
            (error) in
            print(error.localizedDescription)
        } // end of read method
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "group", for: indexPath) as! groupCell
//        cell.taskNameLabel.text = arrOftasks[indexPath.row].name
//        above is an example of setting the name of a cell to the name of a task
//        this method is run automatically n times where n = # of tasks in tasks arr
        return cell
    }
}

class groupCell : UITableViewCell{
    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var memberLabel: UILabel!
    @IBOutlet weak var taskNameLabel : UILabel!
    @IBOutlet weak var isCompleteButton : UIButton!
    
}
