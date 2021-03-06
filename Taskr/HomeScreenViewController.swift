//  HomeScreenViewController.swift
//  Taskr
//  Created by Maxwell Serota (student LM) on 2/23/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
import FirebaseAuth
import FirebaseStorage
import FirebaseDatabase
import UIKit

class HomeScreenViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var groupTableView: UITableView!
    var groupName = ""
    var groupsArray : [String]?
    override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad")
        getGroups()
    }
    
    
    
    @IBAction func clickedNewGroup(_ sender: Any) {
        self.performSegue(withIdentifier: "homeScreenToNewGroup", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("tableView 1")
        do { // will print true or false
            self.groupsArray = try JSONSerialization.readJSON(withFilename: "groups") as! [String]
            return groupsArray!.count
        }
        catch {
            print("Failed to return size of groups array")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tableView 2")
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeScreen", for: indexPath) as! homeScreenCell
        cell.groupNameLabel.text = groupsArray![indexPath.row]
        print("groupsArray at indexPath.row: \(groupsArray![indexPath.row])")
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? homeScreenCell {
            if let groupViewController = segue.destination as? GroupViewController {
                groupViewController.groupName = cell.groupNameLabel.text!
            }
        }
    }
    
    func getGroups (){
        let ref: DatabaseReference! = Database.database().reference()
        print("hey, vSauce, Michael here")
    ref.child("users").child(Auth.auth().currentUser!.displayName!).child("groups").observeSingleEvent(of: .value, with: { (snapshot) in
            if let _ = snapshot.value as? NSNull { // if user has no prior groups
                do { // will print true or false
                    print("no prior groups")
                    try print(JSONSerialization.writeJSON(jsonObject: [] as! [String], toFilename: "groups"))
                }
                catch {
                    print("Failed to write blank groups array")
                }
            }
            else { // if user has prior groups
                do { // will print true or false
                    print("yes prior groups")
                    try print(JSONSerialization.writeJSON(jsonObject: snapshot.value as! NSArray as AnyObject as! [String], toFilename: "groups"))
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

extension JSONSerialization {
    
    static func readJSON(withFilename filename: String) throws -> Any? {
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try Data(contentsOf: fileURL)
            let jsonObject = try JSONSerialization.jsonObject(with: data, options: [.mutableContainers, .mutableLeaves])
            return jsonObject
        }
        return nil
    }
    
    static func writeJSON(jsonObject: Any, toFilename filename: String) throws -> Bool{
        let fm = FileManager.default
        let urls = fm.urls(for: .documentDirectory, in: .userDomainMask)
        if let url = urls.first {
            var fileURL = url.appendingPathComponent(filename)
            fileURL = fileURL.appendingPathExtension("json")
            let data = try JSONSerialization.data(withJSONObject: jsonObject, options: [.prettyPrinted])
            try data.write(to: fileURL, options: [.atomicWrite])
            return true
        }
        
        return false
    }
}

