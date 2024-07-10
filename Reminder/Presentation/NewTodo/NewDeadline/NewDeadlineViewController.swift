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
    private let dateLabel = UILabel()
    let viewModel = NewDeadlineViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindData()
    }
    
    func bindData() {
        viewModel.outputDateLabel.bind { date in
            let myFormatter = DateFormatter()
            myFormatter.dateFormat = "yyyy-MM-dd"
            let dateString = myFormatter.string(from: date)
            self.dateLabel.text = dateString
        }
    }
    
    override func configureView() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        
        saveButton.setTitle("추가하기", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .blue
        saveButton.layer.cornerRadius = 10
        
        dateLabel.text = ""
        dateLabel.font = .boldSystemFont(ofSize: 17)
        dateLabel.backgroundColor = .clear
        dateLabel.textColor = .black
        dateLabel.textAlignment = .center
    }
    
    override func configureTarget() {
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
        datePicker.addTarget(self, action: #selector(changeDate), for: .valueChanged)
    }
    
    override func configureHierarchy() {
        view.addSubview(datePicker)
        view.addSubview(saveButton)
        view.addSubview(dateLabel)
    }
    
    override func configureConstraints() {
        datePicker.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
        
        saveButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(50)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.bottom.equalTo(saveButton.snp.top).inset(-30)
        }
    }
    
    @objc private func saveButtonClicked() {
        onSave?(datePicker.date)
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func changeDate() {
        viewModel.inputDateUpdate.value = datePicker.date
    }
}
