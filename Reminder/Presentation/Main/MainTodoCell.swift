//
//  MainTodoCell.swift
//  Reminder
//
//  Created by 강석호 on 7/4/24.
//

import UIKit
import SnapKit

class MainTodoCell: BaseCollectionViewCell {
    
    static let id = "MainTodoCell"
    let categoryImageView = UIImageView()
    let categoryCount = UILabel()
    let categoryTitle = UILabel()
    
    override func configureHierarchy() {
        addSubview(categoryImageView)
        addSubview(categoryCount)
        addSubview(categoryTitle)
    }
    
    override func configureView() {
        categoryImageView.backgroundColor = .clear
        categoryImageView.layer.cornerRadius = 20
        categoryImageView.image = UIImage(systemName: "star")
        
        categoryCount.font = .boldSystemFont(ofSize: 22)
        categoryCount.textColor = .white
        categoryCount.text = "0"
        
        categoryTitle.font = .boldSystemFont(ofSize: 17)
        categoryTitle.textColor = .white
        categoryTitle.text = "오늘"
    }
    
    override func configureLayout() {
        categoryImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(10)
            make.height.width.equalTo(30)
        }
        categoryCount.snp.makeConstraints { make in
            make.top.equalTo(contentView).inset(10)
            make.leading.equalTo(categoryImageView.snp.trailing).offset(80)
        }
        categoryTitle.snp.makeConstraints { make in
            make.top.equalTo(categoryImageView.snp.bottom).offset(20)
            make.leading.equalTo(contentView).inset(10)
        }
    }
    
}
