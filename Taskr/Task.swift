//
//  Task.swift
//  Taskr
//
//  Created by Alex Gerstein (student LM) on 2/21/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
//

import Foundation

class Task{

    var description = ""
    var person = ""
    var dueDate = Date()
    
    init(description: String, person: String, dueDate: Date){
        self.description = description
        self.person = person
        self.dueDate = dueDate
    }
    
}
