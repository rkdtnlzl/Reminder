//
//  TodoInputViewCell.swift
//  Reminder
//
//  Created by 강석호 on 7/3/24.
//

import UIKit
import SnapKit

class TodoInputViewCell: UITableViewCell {
    func setup(todoInputView: TodoInputView) {
        contentView.addSubview(todoInputView)
        todoInputView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(150)
        }
    }
}
