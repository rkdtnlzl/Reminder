//
//  ViewController.swift
//  Reminder
//
//  Created by 강석호 on 7/2/24.
//

import UIKit
import SnapKit

final class MainViewController: BaseViewController {
    
    private let newTodoButton = UIButton()
    
    override func configureHierarchy() {
        view.addSubview(newTodoButton)
    }
    
    override func configureView() {
        newTodoButton.setImage(UIImage(systemName: "plus"), for: .normal)
        newTodoButton.setTitle("새로운 할 일", for: .normal)
        newTodoButton.setTitleColor(.systemBlue, for: .normal)
    }
    
    override func configureConstraints() {
        newTodoButton.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide).inset(40)
            make.height.equalTo(50)
        }
    }
    
    override func configureTarget() {
        newTodoButton.addTarget(self, action: #selector(newTodoButtonClicked), for: .touchUpInside)
    }
    
    @objc func newTodoButtonClicked() {
        let vc = NewTodoViewController()
        let navVC = UINavigationController(rootViewController: vc)
        navVC.modalPresentationStyle = .pageSheet
        present(navVC, animated: true)
    }
}

