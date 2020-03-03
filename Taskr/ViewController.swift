//
//  ViewController.swift
//  Taskr
//
//  Created by Maxwell Serota (student LM) on 2/19/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
// hey guys, this is Austin

import UIKit
import FirebaseAuth
import FirebaseStorage

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // please commmit
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let _ = Auth.auth().currentUser{
            self.performSegue(withIdentifier: "launchToHomeScreen", sender: self)
        }
    }


}


