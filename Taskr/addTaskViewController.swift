//
//  addTaskViewController.swift
//  Taskr
//
//  Created by Alex Gerstein (student LM) on 2/27/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.

import UIKit

class addTaskViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var addTaskButton: UIButton!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var dueDateTextField: UITextField!
    @IBOutlet weak var assignedToTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextField.delegate = self
        dueDateTextField.delegate = self
        assignedToTextField.delegate = self
        descriptionTextField.becomeFirstResponder()
        addTaskButton.isEnabled = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if descriptionTextField.isFirstResponder {
            dueDateTextField.becomeFirstResponder()
        }
        else if dueDateTextField.isFirstResponder {
            assignedToTextField.becomeFirstResponder()
        }
        else {
            assignedToTextField.resignFirstResponder()
            addTaskButton.isEnabled = true
        }
        return true
    }
    
    @IBAction func addTaskButtonClicked(_ sender: UIButton) {
        
    }
    

}
