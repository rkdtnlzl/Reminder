//
//  NewDeadlineViewController.swift
//  Reminder
//
//  Created by 강석호 on 7/3/24.
//

import UIKit
import SnapKit
import RealmSwift

final class NewDeadlineViewController: BaseViewController {
    
    private let datePicker = UIDatePicker()
    private let saveButton = UIButton()
    var onSave: ((Date) -> Void)?
    
    override func configureView() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        
        saveButton.setTitle("추가하기", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .blue
        saveButton.layer.cornerRadius = 10
    }
    
    override func configureTarget() {
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
        view.addSubview(saveButton)
    }
    
    override func configureConstraints() {
        datePicker.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        
        saveButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(50)
        }
    }
    
    @objc private func saveButtonClicked() {
        onSave?(datePicker.date)
        navigationController?.popViewController(animated: true)
    }
}
