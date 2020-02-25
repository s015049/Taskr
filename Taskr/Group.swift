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
    
    init(members: [String], tasks: [Task]){
        self.members = members
        self.tasks = tasks
    }
    
}
