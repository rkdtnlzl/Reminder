//
//  NewTodoViewModel.swift
//  Reminder
//
//  Created by 강석호 on 7/9/24.
//

import Foundation

class NewDeadlineViewModel {
    
    var inputDateUpdate: Observable<Date> = (Observable(Date()))
    
    var outputDateLabel: Observable<Date> = (Observable(Date()))
    
    init() {
        inputDateUpdate.bind { [weak self] _ in
            self?.updateDate()
        }
    }
    
    private func updateDate() {
        let date = self.inputDateUpdate.value
        outputDateLabel.value = date
        print("업데이트됨")
    }
}
