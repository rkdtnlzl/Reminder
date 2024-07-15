//
//  CalendarViewController.swift
//  Reminder
//
//  Created by 강석호 on 7/15/24.
//

import UIKit
import SnapKit
import FSCalendar

class CalendarViewController: BaseViewController {
    
    var calendar: FSCalendar = FSCalendar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCalendar()
    }
    
    func configureCalendar() {
        calendar = FSCalendar()
        calendar.dataSource = self
        calendar.delegate = self
    }
    
    override func configureHierarchy() {
        view.addSubview(calendar)
    }
    
    override func configureConstraints() {
        calendar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(400)
        }
    }
}

extension CalendarViewController: FSCalendarDataSource, FSCalendarDelegate {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("Selected date: \(date)")
    }
    
    func minimumDate(for calendar: FSCalendar) -> Date {
        return Date()
    }
    
    func maximumDate(for calendar: FSCalendar) -> Date {
        return Calendar.current.date(byAdding: .year, value: 1, to: Date())!
    }
}
