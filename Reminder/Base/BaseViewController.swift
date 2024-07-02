//
//  BaseViewController.swift
//  Reminder
//
//  Created by 강석호 on 7/2/24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .white
        configureHierarchy()
        configureView()
        configureConstraints()
        configureTarget()
    }
     
    func configureHierarchy() { }
    
    func configureView() { }
    
    func configureConstraints() { }
    
    func configureTarget() { }
}
