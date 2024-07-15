//
//  MainViewModel.swift
//  Reminder
//
//  Created by 강석호 on 7/15/24.
//

import Foundation

class MainViewModel {
    
    var todoRepository = TodoTableRepository()
    var folderRepository = FolderRepository()
    
    var inputMainViewDidLoadTrigger: Observable<Void?> = Observable(nil)

    var outputTodoCount = Observable(0)
    var outputFolders = Observable<[Folder]>([])
    
    init() {
        inputMainViewDidLoadTrigger.bind { _ in
            self.loadData()
        }
    }
    
    private func loadData() {
        outputTodoCount.value = todoRepository.countItems()
        outputFolders.value = folderRepository.fetchAllFolders().map { $0 }
    }
}
