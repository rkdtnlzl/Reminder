//
//  TodoListViewController.swift
//  Reminder
//
//  Created by 강석호 on 7/5/24.
//

import UIKit
import SnapKit
import RealmSwift

final class TodoListViewController: BaseViewController {
    
    let tableView = UITableView()
    private var repository = TodoTableRepository()
    var todoData: Results<TodoTable>!
    var folder: Folder?
    
    init(folder: Folder?) {
        self.folder = folder
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()
        loadTodoItems()
    }
    
    private func loadTodoItems() {
        if let folder = folder {
            todoData = folder.folderList.sorted(byKeyPath: "deadline", ascending: true)
            navigationItem.title = "\(folder.folderName) 모음"
        } else {
            todoData = repository.fetchAllItems()
            navigationItem.title = "전체 할 일"
        }
        tableView.reloadData()
    }
    
    private func configureNavigation() {
        let rightBarButton = UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"), style: .plain, target: self, action: #selector(showSortOptions))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(TodoListCell.self, forCellReuseIdentifier: "TodoListCell")
        tableView.rowHeight = 120
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func showSortOptions() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "마감일순", style: .default, handler: { _ in
            self.sortByDeadLine()
        }))
        alert.addAction(UIAlertAction(title: "우선순위순", style: .default, handler: { _ in
            self.sortByPriority()
        }))
        present(alert, animated: true)
    }
    
    private func sortByDeadLine() {
        todoData = todoData.sorted(byKeyPath: "deadline", ascending: true)
        tableView.reloadData()
    }
    
    private func sortByPriority() {
        todoData = todoData.sorted(byKeyPath: "priority", ascending: true)
        tableView.reloadData()
    }
    
}

extension TodoListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoData?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TodoListCell.id) as! TodoListCell
        let data = todoData[indexPath.row]
        cell.titleLabel.text = data.title
        cell.descriptionLabel.text = data.memo ?? ""
        cell.tagLabel.text = data.tag ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "삭제") { action, view, completionHandler in
            let deleteItem = self.todoData[indexPath.row]
            self.repository.deleteItem(deleteItem)
            tableView.performBatchUpdates({
                self.todoData = self.repository.fetchAllItems()
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }, completion: nil)
            completionHandler(true)
        }
        let editAction = UIContextualAction(style: .normal, title: "수정") { action, view, completionHandler in
            let itemToEdit = self.todoData[indexPath.row]
            let modifyVC = TodoModifyViewController()
            modifyVC.todoItem = itemToEdit
            modifyVC.modalPresentationStyle = .overFullScreen
            modifyVC.modalTransitionStyle = .coverVertical
            self.present(modifyVC, animated: true)
            completionHandler(true)
        }
        editAction.backgroundColor = .blue
        
        return UISwipeActionsConfiguration(actions: [deleteAction, editAction])
    }
}
