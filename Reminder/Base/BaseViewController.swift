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
    
    func showAlert(title: String, message: String, ok: String, completionHandler: @escaping (UIAlertAction) -> Void) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "취소", style: .cancel)
            let okAction = UIAlertAction(title: ok, style: .default, handler: completionHandler)
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true)
        }
}
