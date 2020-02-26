//
//  HomeScreenViewController.swift
//  Taskr
//
//  Created by Maxwell Serota (student LM) on 2/23/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
//
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import UIKit
class homeScreenCell : UITableViewCell{
    
}

class HomeScreenViewController: UIViewController {

    @IBOutlet weak var completionButton: UIButton!
    @IBOutlet weak var groupName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
