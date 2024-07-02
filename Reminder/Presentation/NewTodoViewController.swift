//
//  NewTodoViewController.swift
//  Reminder
//
//  Created by 강석호 on 7/2/24.
//

import UIKit
import SnapKit
import RealmSwift

final class NewTodoViewController: BaseViewController {
    
    let tableView = UITableView()
    private let todoInputView = TodoInputView()
    
    private var realm: Realm!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configureRealm()
    }
    
    private func configureRealm() {
        realm = try! Realm()
    }
    
    override func configureHierarchy() {
        view.addSubview(todoInputView)
    }
    
    override func configureConstraints() {
        todoInputView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(150)
        }
    }
    
    override func configureTarget() {
        todoInputView.titleTextField.addTarget(self, action: #selector(updateAddButtonState), for: .editingChanged)
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "새로운 할 일"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .done, target: self, action: #selector(addTodo))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = UIColor.systemBlue
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(dismissViewController))
    }

    @objc private func updateAddButtonState() {
        let isNotEmpty = !(todoInputView.titleTextField.text?.isEmpty ?? true)
        navigationItem.rightBarButtonItem?.isEnabled = isNotEmpty
        navigationItem.rightBarButtonItem?.tintColor = isNotEmpty ? UIColor.systemBlue : UIColor.gray
    }
    
    @objc private func addTodo() {
        print(realm.configuration.fileURL!)
        let data = TodoTable()
        data.title = todoInputView.titleTextField.text ?? ""
        data.memo = todoInputView.memoTextView.text.isEmpty ? nil : todoInputView.memoTextView.text
        try! realm.write {
            realm.add(data)
        }
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true, completion: nil)
    }
}
