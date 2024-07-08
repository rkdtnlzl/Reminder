//
//  TodoTableRepository.swift
//  Reminder
//
//  Created by 강석호 on 7/5/24.
//

import Foundation
import RealmSwift

final class TodoTableRepository {
    
    private let realm = try! Realm()
    
    func createItem(_ data: TodoTable) {
        
        do {
            try realm.write {
                realm.add(data)
                print("Realm Create Success")
            }
        } catch {
            print("Realm Error")
        }
    }
    
    func countItems() -> Int {
        return realm.objects(TodoTable.self).count
    }
    
    func deleteItem(_ data: TodoTable) {
        try! realm.write {
            realm.delete(data)
        }
    }
    
    func fetchAllItems() -> Results<TodoTable> {
        return realm.objects(TodoTable.self)
    }
    
    func updateMemo(_ data: TodoTable, newMemo: String?) {
        try! realm.write {
            data.memo = newMemo
            realm.add(data, update: .modified)
        }
    }
    
    func detectRealmURL() {
        print(realm.configuration.fileURL!)
    }
}
