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
   var homeScreenViewController : HomeScreenViewController = HomeScreenViewController()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
      override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        homeScreenViewController.groupTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // this should be # of tasks in group
        // return tasksArr.size()
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
    @IBOutlet weak var taskNameLabel : UILabel!
    @IBOutlet weak var isCompleteButton : UIButton!
    
}
