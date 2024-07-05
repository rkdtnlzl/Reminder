//
//  Todo.swift
//  Reminder
//
//  Created by 강석호 on 7/2/24.
//

import RealmSwift
import Foundation

class TodoTable: Object {
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var deadline: Date?
    @Persisted var tag: String?
    @Persisted var priority: String?

    
    convenience init(title: String, memo: String?, deadline: Date?, tag: String?, priority: String?) {
        self.init()
        self.title = title
        self.memo = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
    }
}
