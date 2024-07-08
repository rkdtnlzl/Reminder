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
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped)
    private let todoInputView = TodoInputView()
    private var realm: Realm!
    private var selectedDeadline: Date?
    private var selectedTag: String?
    private var selectedPriority: String?
    private var folderRepository = FolderRepository()
    
    private let sectionTitles = ["할 일 입력", "마감일", "태그", "우선 순위", "이미지 추가"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        configureRealm()
        configureTableView()
        print(realm.configuration.fileURL!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func configureRealm() {
        realm = try! Realm()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "새로운 할 일"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "추가", style: .done, target: self, action: #selector(addTodo))
        navigationItem.rightBarButtonItem?.isEnabled = false
        navigationItem.rightBarButtonItem?.tintColor = UIColor.systemBlue
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(dismissViewController))
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.register(TodoInputViewCell.self, forCellReuseIdentifier: "TodoInputViewCell")
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureTarget() {
        todoInputView.titleTextField.addTarget(self, action: #selector(updateAddButtonState), for: .editingChanged)
    }
    
    @objc private func updateAddButtonState() {
        let isNotEmpty = !(todoInputView.titleTextField.text?.isEmpty ?? true)
        navigationItem.rightBarButtonItem?.isEnabled = isNotEmpty
        navigationItem.rightBarButtonItem?.tintColor = isNotEmpty ? UIColor.systemBlue : UIColor.gray
    }
    
    @objc private func addTodo() {
        let newTodo = TodoTable()
        try! realm.write {
            newTodo.title = todoInputView.titleTextField.text ?? ""
            newTodo.memo = todoInputView.memoTextView.text.isEmpty ? nil : todoInputView.memoTextView.text
            newTodo.deadline = selectedDeadline
            newTodo.tag = selectedTag
            newTodo.priority = selectedPriority
            realm.add(newTodo)
        }
        folderRepository.addFolder(to: newTodo)
        try! realm.write {
            realm.add(newTodo)
        }
        NotificationCenter.default.post(name: NSNotification.Name("newTodoAdded"), object: nil)
        dismiss(animated: true)
    }
    
    @objc private func dismissViewController() {
        NotificationCenter.default.post(name: NSNotification.Name("newTodoAdded"), object: nil)
        dismiss(animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}

extension NewTodoViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TodoInputViewCell", for: indexPath) as! TodoInputViewCell
            cell.setup(todoInputView: todoInputView)
            return cell
        } else {
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "cell")
            cell.textLabel?.text = sectionTitles[indexPath.section]
            cell.accessoryType = .disclosureIndicator
            
            if indexPath.section == 1,
               let deadline = selectedDeadline {
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                cell.detailTextLabel?.text = formatter.string(from: deadline)
            } else if indexPath.section == 2,
                      let tag = selectedTag {
                cell.detailTextLabel?.text = tag
                print(tag)
            } else if indexPath.section == 3,
                      let priority = selectedPriority {
                cell.detailTextLabel?.text = priority
                print(priority)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 1 {
            let deadlineVC = NewDeadlineViewController()
            deadlineVC.onSave = { [weak self] date in
                self?.selectedDeadline = date
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            }
            navigationController?.pushViewController(deadlineVC, animated: true)
        } else if indexPath.section == 2 {
            let tagVC = NewTagViewController()
            tagVC.onSave = { [weak self] tag in
                self?.selectedTag = tag
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            }
            navigationController?.pushViewController(tagVC, animated: true)
        } else if indexPath.section == 3 {
            let priorityVC = NewPriorityViewController()
            priorityVC.onSave = { [weak self] priority in
                self?.selectedPriority = priority
                self?.tableView.reloadRows(at: [indexPath], with: .none)
            }
            navigationController?.pushViewController(priorityVC, animated: true)
        }
    }
}
