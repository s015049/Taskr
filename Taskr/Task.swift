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
    var groupName = ""
    var isCompleted : Bool

    init(description: String, person: String, dueDate: String, groupName: String){
        self.description = description
        self.person = person
        self.dueDate = dueDate
        self.isCompleted = false
        self.groupName = groupName
    }
    
    init(description: String, person: String, dueDate: String, groupName: String, isCompleted: Bool){
        self.description = description
        self.person = person
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.groupName = groupName
    }
    
    init() {
        self.description = ""
        self.person = ""
        self.dueDate = ""
        self.isCompleted = false
        self.groupName = ""
        
    }
    
    func toString() -> String {
        return "\(description),\(person),\(dueDate),\(groupName),\(isCompleted ? "true" : "false" )"
    }
    
    func fromString (s: String) -> Task { // entering multiple group members with , speration will break this
        let arr = s.components(separatedBy: ",")
        return Task (description: arr[0], person: arr[1], dueDate: arr[2], groupName: arr[3], isCompleted: arr[4] == "true" ? true : false)
    }

}
