//
//  NewPriorityViewController.swift
//  Reminder
//
//  Created by 강석호 on 7/3/24.
//

import UIKit
import SnapKit

final class NewPriorityViewController: BaseViewController {
    
    let tableView = UITableView()
    let priorityList = ["높음", "중간", "낮음"]
    var selectedIndexPath: IndexPath?
    let saveButton = UIButton()
    var onSave: ((String) -> Void)?
    var selectedPriority: String = "높음"
    let viewModel = NewPriorityViewModel()
    let priorityLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        bindData()
    }
    
    func bindData() {
        viewModel.outputPriorityLabel.bind { [weak self] value in
            self?.priorityLabel.text = value
        }
    }
    
    override func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(saveButton)
        view.addSubview(priorityLabel)
    }
    
    private func configureTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func configureView() {
        saveButton.setTitle("추가하기", for: .normal)
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.backgroundColor = .blue
        saveButton.layer.cornerRadius = 10
        
        priorityLabel.text = ""
        priorityLabel.font = .boldSystemFont(ofSize: 17)
        priorityLabel.backgroundColor = .clear
        priorityLabel.textColor = .black
        priorityLabel.textAlignment = .center
    }
    
    override func configureTarget() {
        saveButton.addTarget(self, action: #selector(saveButtonClicked), for: .touchUpInside)
    }
    
    override func configureConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.bottom.equalTo(view.safeAreaLayoutGuide).inset(200)
        }
        saveButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(50)
        }
        priorityLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.bottom.equalTo(saveButton.snp.top).inset(-30)
        }
    }
    
    @objc private func saveButtonClicked() {
        onSave?(selectedPriority)
        navigationController?.popViewController(animated: true)
    }
}

extension NewPriorityViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return priorityList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = priorityList[indexPath.row]
        if selectedIndexPath == indexPath {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let prevIndexPath = selectedIndexPath {
            let prevCell = tableView.cellForRow(at: prevIndexPath)
            prevCell?.accessoryType = .none
        }
        let selectedCell = tableView.cellForRow(at: indexPath)
        selectedCell?.accessoryType = .checkmark
        selectedIndexPath = indexPath
        selectedPriority = priorityList[indexPath.row]
        
        viewModel.inputPriorityIndex.value = selectedIndexPath?.row ?? 0
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
