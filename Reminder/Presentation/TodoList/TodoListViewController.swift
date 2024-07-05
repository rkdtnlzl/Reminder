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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadTodoItems()
    }
    
    private func loadTodoItems() {
        todoData = repository.fetchAllItems()
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    override func configureView() {
        navigationItem.title = "할 일 목록"
        
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
}
