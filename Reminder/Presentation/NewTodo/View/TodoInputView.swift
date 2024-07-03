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
    let lineView = UIView()
    private var memoPlaceholderLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(titleTextField)
        addSubview(memoTextView)
        addSubview(lineView)
        memoTextView.addSubview(memoPlaceholderLabel)
    }
    
    override func configureLayout() {
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(titleTextField.snp.bottom)
            make.leading.equalTo(self.safeAreaLayoutGuide).inset(10)
            make.trailing.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        memoTextView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
        
        memoPlaceholderLabel.snp.makeConstraints { make in
            make.top.equalTo(memoTextView).inset(8)
            make.horizontalEdges.equalTo(memoTextView).inset(10)
        }
    }
    
    override func configureView() {
        titleTextField.placeholder = "제목"
        titleTextField.font = UIFont.systemFont(ofSize: 16)
        titleTextField.tintColor = .lightGray
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: titleTextField.frame.height))
        titleTextField.leftView = paddingView
        titleTextField.leftViewMode = .always
        
        memoTextView.font = UIFont.systemFont(ofSize: 16)
        memoTextView.isScrollEnabled = true
        memoTextView.delegate = self
        
        memoPlaceholderLabel.text = "메모"
        memoPlaceholderLabel.font = UIFont.systemFont(ofSize: 16)
        memoPlaceholderLabel.textColor = UIColor.lightGray
        memoPlaceholderLabel.isHidden = !memoTextView.text.isEmpty
        
        lineView.backgroundColor = .lightGray
    }
}

extension TodoInputView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        memoPlaceholderLabel.isHidden = !textView.text.isEmpty
    }
}
