//
//  ViewController.swift
//  Reminder
//
//  Created by 강석호 on 7/2/24.
//

import UIKit
import SnapKit
import RealmSwift

final class MainViewController: BaseViewController {
    
    private let newTodoButton = UIButton()
    private let totalLabel = UILabel()
    lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout())
    private var todoRepository = TodoTableRepository()
    private var folderRepository = FolderRepository()
    private var folders: Results<Folder>?
    private var todoCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTodoCount()
        loadFolders()
        configureNotificationObservers()
    }
    
    override func configureHierarchy() {
        view.addSubview(newTodoButton)
        view.addSubview(totalLabel)
        view.addSubview(collectionView)
    }
    
    override func configureView() {
        newTodoButton.setImage(UIImage(systemName: "plus"), for: .normal)
        newTodoButton.setTitle("새로운 할 일", for: .normal)
        newTodoButton.setTitleColor(.systemBlue, for: .normal)
        
        totalLabel.font = .boldSystemFont(ofSize: 25)
        totalLabel.text = "전체"
        totalLabel.textColor = .gray
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainTodoCell.self, forCellWithReuseIdentifier: MainTodoCell.id)
    }
    
    override func configureConstraints() {
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(totalLabel.snp.bottom).offset(10)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.bottom.equalTo(newTodoButton.snp.top).inset(-20)
        }
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
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width - 40
        layout.itemSize = CGSize(width: width/2-10, height: width/3-10)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        return layout
    }
    
    private func loadTodoCount() {
        todoCount = todoRepository.countItems()
        collectionView.reloadData()
    }
    
    private func loadFolders() {
        folders = folderRepository.fetchAllFolders()
        collectionView.reloadData()
    }
    
    private func configureNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(todoAdded), name: NSNotification.Name("newTodoAdded"), object: nil)
    }
    
    @objc private func todoAdded() {
        loadTodoCount()
        loadFolders()
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (folders?.count ?? 0) + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainTodoCell.id, for: indexPath) as? MainTodoCell else {
            return UICollectionViewCell()
        }
        cell.backgroundColor = .lightGray
        cell.layer.cornerRadius = 10
        
        if indexPath.row == 0 {
            cell.categoryTitle.text = "전체"
            cell.categoryCount.text = "\(todoCount)"
        } else if let folder = folders?[indexPath.row - 1] {
            cell.categoryTitle.text = folder.folderName
            cell.categoryCount.text = "\(folder.folderList.count)"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = TodoListViewController(folder: nil)
            navigationController?.pushViewController(vc, animated: true)
        } else if let folder = folders?[indexPath.row - 1] {
            let vc = TodoListViewController(folder: folder)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
