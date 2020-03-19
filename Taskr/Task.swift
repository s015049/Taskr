//
//  Task.swift
//  Taskr
//
//  Created by Maxwell Serota (student LM) on 2/25/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
//

import Foundation
class Task{

    var description = ""
    var person = ""
    var dueDate = ""
    var isCompleted : Bool

    init(description: String, person: String, dueDate: String){
        self.description = description
        self.person = person
        self.dueDate = dueDate
        self.isCompleted = false
    }
    
    init(description: String, person: String, dueDate: String, isCompleted: Bool){
        self.description = description
        self.person = person
        self.dueDate = dueDate
        self.isCompleted = false
    }
    
    init() {
        self.description = ""
        self.person = ""
        self.dueDate = ""
        self.isCompleted = false
    }
    
    func toString() -> String {
        return "\(description),\(person),\(dueDate),\(isCompleted ? "true" : "false" )"
    }
    
    func fromString (s: String) -> Task {
        let arr = s.components(separatedBy: ",")
        return Task (description: arr[0], person: arr[1], dueDate: arr[2], isCompleted: arr[3] == "true" ? true : false)
    }

}
