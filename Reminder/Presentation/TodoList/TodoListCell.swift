//
//  TodoListCell.swift
//  Reminder
//
//  Created by 강석호 on 7/6/24.
//

import UIKit
import SnapKit

class TodoListCell: BaseTableViewCell {
    
    static let id = "TodoListCell"
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let tagLabel = UILabel()
    
    override func configureHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(tagLabel)
    }
    
    override func configureView() {
        titleLabel.font = .boldSystemFont(ofSize: 17)
        titleLabel.textColor = .black
        titleLabel.text = "test"
        
        descriptionLabel.font = .systemFont(ofSize: 15)
        descriptionLabel.textColor = .gray
        descriptionLabel.text = "test1"
        
        tagLabel.font = .systemFont(ofSize: 15)
        tagLabel.textColor = .blue
        tagLabel.text = "test2"
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        tagLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
    }
}
