//
//  NewTagViewController.swift
//  Reminder
//
//  Created by 강석호 on 7/3/24.
//

import UIKit
import SnapKit

final class NewTagViewController: BaseViewController {
    
    private let tagField = UITextField()
    private let saveButton = UIButton()
    var onSave: ((String) -> Void)?
    
    
    override func configureHierarchy() {
        view.addSubview(tagField)
        view.addSubview(saveButton)
    }
    
    override func configureView() {
        tagField.placeholder = "태그를 입력하세요(Ex. #운동)"
        tagField.backgroundColor = .white
        tagField.borderStyle = .roundedRect
        
        saveButton.setTitle("추가하기", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .blue
        saveButton.layer.cornerRadius = 10
    }
    
    override func configureConstraints() {
        tagField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(30)
        }
        
        saveButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(50)
        }
    }
    
    override func configureTarget() {
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    @objc private func saveButtonClicked() {
        if let text = tagField.text {
            onSave?(text)
        }
        navigationController?.popViewController(animated: true)
    }
}
