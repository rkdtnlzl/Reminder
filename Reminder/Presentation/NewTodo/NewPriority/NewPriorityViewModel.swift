//
//  NewPriorityViewModel.swift
//  Reminder
//
//  Created by 강석호 on 7/9/24.
//

import Foundation

class NewPriorityViewModel {
    
    var inputPriorityIndex = Observable(0)
    
    var outputPriorityLabel = Observable("")
    
    init() {
        inputPriorityIndex.bind { [weak self] _ in
            self?.updatePriority()
        }
    }
    
    private func updatePriority() {
        
        if inputPriorityIndex.value == 0 {
            outputPriorityLabel.value = "높음"
        } else if inputPriorityIndex.value == 1 {
            outputPriorityLabel.value = "중간"
        } else {
            outputPriorityLabel.value = "낮음"
        }
    }
}
