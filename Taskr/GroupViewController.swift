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
    var tasksArr : [String] = []
    var homeScreenViewController : HomeScreenViewController = HomeScreenViewController()
    
    override func viewDidLoad() {
        groupNameLabel.text! = groupName
        super.viewDidLoad()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //homeScreenViewController.groupTableView.reloadData()
        // above causes SIGABERT
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        do { // will print true or false
            self.tasksArr = try JSONSerialization.readJSON(withFilename: "tasks") as! [String]
            return tasksArr.count
        }
        catch {
            print("Failed to return size of tasks array")
            return 0
        }
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
                print("yes prior tasks")
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
        var task: Task = Task(); task = task.fromString(s: tasksArr[indexPath.row])
        cell.dueDateLabel.text = task.dueDate
        cell.descriptionLabel.text = task.description
        var members : String = task.member
        for var i in range 0...members.count-1{
            if members[i] == "/"{
                members[i] = ", "
            }
        }
        cell.memberLabel.text = members
        cell.taskNameLabel.text = task.taskName
        //cell.isCompleteButton.state = // not sure how this should work
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
