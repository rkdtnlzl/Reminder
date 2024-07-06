//
//  TodoModifyViewController.swift
//  Reminder
//
//  Created by 강석호 on 7/6/24.
//

import UIKit
import SnapKit
import RealmSwift

class TodoModifyViewController: BaseViewController {
    
    var todoItem: TodoTable?
    private let textView = UITextView()
    private let repository = TodoTableRepository()
    private let saveButton = UIButton()
    private let cancelButton = UIButton()
    
    override func configureHierarchy() {
        view.addSubview(textView)
        view.addSubview(saveButton)
        view.addSubview(cancelButton)
    }
    
    override func configureView() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        
        textView.backgroundColor = .white
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = todoItem?.memo ?? ""
        
        saveButton.layer.cornerRadius = 8
        saveButton.backgroundColor = .darkGray
        saveButton.setTitle("저장", for: .normal)
        
        cancelButton.layer.cornerRadius = 8
        cancelButton.backgroundColor = .darkGray
        cancelButton.setTitle("취소", for: .normal)
    }
    
    override func configureConstraints() {
        textView.snp.makeConstraints { make in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.height.equalTo(200)
        }
        saveButton.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom)
            make.leading.equalTo(view.snp.centerX).offset(10)
            make.height.equalTo(50)
            make.width.equalTo(80)
        }
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(textView.snp.bottom)
            make.trailing.equalTo(view.snp.centerX).offset(-10)
            make.height.equalTo(50)
            make.width.equalTo(80)
        }
    }
    
    override func configureTarget() {
        saveButton.addTarget(self, action: #selector(saveMemo), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
    }

    @objc private func saveMemo() {
        if let item = todoItem {
            repository.updateMemo(item, newMemo: textView.text)
        }
        dismiss(animated: true)
    }

    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}

