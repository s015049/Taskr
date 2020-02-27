//
//  Group.swift
//  Taskr
//
//  Created by Maxwell Serota (student LM) on 2/25/20.
//  Copyright © 2020 BigBrainCorporation. All rights reserved.
//

import Foundation
class Group {
    
    var members = [""]
    var tasks: [Task] = []
    var name = ""
    
    init(members: [String], tasks: [Task], name: String){
        self.members = members
        self.tasks = tasks
        self.name = name
        
    }
    
}
