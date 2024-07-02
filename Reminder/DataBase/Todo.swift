//
//  Todo.swift
//  Reminder
//
//  Created by 강석호 on 7/2/24.
//

import RealmSwift

class TodoTable: Object {
    @Persisted var title: String
    @Persisted var memo: String?
}
