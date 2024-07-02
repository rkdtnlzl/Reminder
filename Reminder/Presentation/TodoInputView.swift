//
//  TodoInputView.swift
//  Reminder
//
//  Created by 강석호 on 7/2/24.
//

import UIKit
import SnapKit

class TodoInputView: BaseView {
    
    let titleTextField = UITextField()
    let memoTextView = UITextView()
    private var memoPlaceholderLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(titleTextField)
        addSubview(memoTextView)
        memoTextView.addSubview(memoPlaceholderLabel)
    }
    
    override func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        memoPlaceholderLabel.snp.makeConstraints { make in
            make.top.equalTo(memoTextView).inset(8)
            make.horizontalEdges.equalTo(memoTextView)
        }
    }
    
    override func configureView() {
        titleTextField.placeholder = "제목"
        titleTextField.layer.borderColor = UIColor.gray.cgColor
        titleTextField.layer.borderWidth = 1
        titleTextField.font = UIFont.systemFont(ofSize: 16)
        titleTextField.tintColor = .lightGray
        
        memoTextView.font = UIFont.systemFont(ofSize: 16)
        memoTextView.layer.borderColor = UIColor.gray.cgColor
        memoTextView.layer.borderWidth = 1
        memoTextView.isScrollEnabled = true
        memoTextView.delegate = self
        
        memoPlaceholderLabel.text = "메모"
        memoPlaceholderLabel.font = UIFont.systemFont(ofSize: 16)
        memoPlaceholderLabel.textColor = UIColor.lightGray
        memoPlaceholderLabel.isHidden = !memoTextView.text.isEmpty
    }
}

extension TodoInputView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        memoPlaceholderLabel.isHidden = !textView.text.isEmpty
    }
}
