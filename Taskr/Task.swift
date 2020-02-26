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
    var dueDate = Date()

    init(description: String, person: String, dueDate: Date){
        self.description = description
        self.person = person
        self.dueDate = dueDate
    }
    
    init() {
        self.description = ""
        self.person = ""
        self.dueDate = Date()
    }

}
