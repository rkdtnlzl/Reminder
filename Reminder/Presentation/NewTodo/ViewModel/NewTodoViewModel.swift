//
//  NewTodoViewModel.swift
//  Reminder
//
//  Created by 강석호 on 7/10/24.
//

import Foundation
import RealmSwift

class NewTodoViewModel {
    let folderRepository = FolderRepository()
    private let todoInputView = TodoInputView()
    private var realm: Realm!
    
    var inputAddButtonTapped: Observable<Void?> = (Observable(nil))
    var inputTitle = Observable("")
    var inputMemo = Observable("")
    var inputDeadline = Observable(Date())
    var inputTag = Observable("")
    var inputPriority = Observable("")
    
    var outputSaveResult = Observable<Bool>(false)
    
    init() {
        
        do {
            realm = try Realm()
        } catch {
            print("\(error)")
        }
        
        inputAddButtonTapped.bind { _ in
            print("Add clicked")
            
            print(self.inputTitle)
            print(self.inputMemo)
            print(self.inputDeadline.value)
            print(self.inputTag.value)
            print(self.inputPriority.value)
            
            self.addNewTodo(newTitle: self.inputTitle.value,
                            newMemo: self.inputMemo.value,
                            selectedDeadline: self.inputDeadline.value,
                            selectedTag: self.inputTag.value,
                            selectedPriority: self.inputPriority.value)
        }
    }
    
    func addNewTodo(newTitle: String, newMemo: String? ,selectedDeadline: Date?, selectedTag: String?, selectedPriority: String?) {
        self.outputSaveResult.value = true
        
        let newTodo = TodoTable()
        try! realm.write {
            newTodo.title = newTitle
            newTodo.memo = newMemo ?? ""
            newTodo.deadline = selectedDeadline ?? Date()
            let isNotEmpty = !(selectedTag?.isEmpty ?? true)
            newTodo.tag = isNotEmpty ? selectedTag : "태그없음"
            newTodo.priority = selectedPriority ?? ""
            realm.add(newTodo)
        }
        folderRepository.addFolder(to: newTodo)
        try! realm.write {
            realm.add(newTodo)
        }
        NotificationCenter.default.post(name: NSNotification.Name("newTodoAdded"), object: nil)
    }
}
