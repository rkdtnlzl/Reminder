//
//  NewTodoViewModel.swift
//  Reminder
//
//  Created by 강석호 on 7/9/24.
//

import Foundation

class NewDeadlineViewModel {
    
    var inputDateUpdate: Observable<Date?> = (Observable(nil))
    
    var outputDateLabel: Observable<Date?> = (Observable(nil))
    
    init() {
        inputDateUpdate.bind { _ in
            self.updateDate()
        }
    }
    
    private func updateDate() {
        let date = self.inputDateUpdate.value
        outputDateLabel.value = date
        print("업데이트됨")
    }
}
