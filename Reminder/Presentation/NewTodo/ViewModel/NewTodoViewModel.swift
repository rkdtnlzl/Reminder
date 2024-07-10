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
    var outputSaveResult = Observable<Bool>(false)
        inputAddButtonTapped.bind { _ in
            print("Add clicked")
        }
    }
}
