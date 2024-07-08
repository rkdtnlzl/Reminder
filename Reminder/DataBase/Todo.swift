//
//  Todo.swift
//  Reminder
//
//  Created by 강석호 on 7/2/24.
//

import RealmSwift
import Foundation

class Folder: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var folderList: List<TodoTable>
    @Persisted var folderName: String
    @Persisted var folderImage: String

    convenience init(tag: String) {
        self.init()
        self.folderName = tag
        self.folderImage = "star"
    }
}

class TodoTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var title: String
    @Persisted var memo: String?
    @Persisted var deadline: Date?
    @Persisted var tag: String?
    @Persisted var priority: String?
    
    @Persisted(originProperty: "folderList")
    var main: LinkingObjects<Folder>
    
    convenience init(title: String, memo: String?, deadline: Date?, tag: String?, priority: String?) {
        self.init()
        self.title = title
        self.memo = memo
        self.deadline = deadline
        self.tag = tag
        self.priority = priority
    }
}
