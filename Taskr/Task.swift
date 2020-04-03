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
    var member = ""
    var dueDate = ""
    var groupName = ""
    var isCompleted : Bool
    var taskName = ""

    init(description: String, person: String, dueDate: String, groupName: String, taskName: String){
        self.description = description
        self.member = person
        self.dueDate = dueDate
        self.isCompleted = false
        self.groupName = groupName
        self.taskName = taskName
    }
    
    init(description: String, person: String, dueDate: String, groupName: String, isCompleted: Bool, taskName: String){
        self.description = description
        self.member = person
        self.dueDate = dueDate
        self.isCompleted = isCompleted
        self.groupName = groupName
        self.taskName = taskName
    }
    
    init() {
        self.description = ""
        self.member = ""
        self.dueDate = ""
        self.isCompleted = false
        self.groupName = ""
        self.taskName = ""
        
    }
    
    func toString() -> String {
        return "\(description),\(member),\(dueDate),\(groupName),\(isCompleted ? "true" : "false" ),\(taskName)"
    }
    
    func fromString (s: String) -> Task { // entering multiple group members with , speration will break this
        let arr = s.components(separatedBy: ",")
        return Task (description: arr[0], person: arr[1], dueDate: arr[2], groupName: arr[3], isCompleted: arr[4] == "true" ? true : false, taskName: arr[5])
    }

}
