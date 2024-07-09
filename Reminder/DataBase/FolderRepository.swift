//
//  FolderRepository.swift
//  Reminder
//
//  Created by 강석호 on 7/8/24.
//

import Foundation
import RealmSwift

final class FolderRepository {
    private let realm = try! Realm()
    
    func fetchAllFolders() -> Results<Folder> {
        return realm.objects(Folder.self)
    }

    func addFolder(to todo: TodoTable) {
        guard let tag = todo.tag else { return }
        
        if let existingFolder = realm.objects(Folder.self).filter("folderName == %@", tag).first {
            try! realm.write {
                existingFolder.folderList.append(todo)
            }
        } else {
            let newFolder = Folder(tag: tag)
            try! realm.write {
                realm.add(newFolder)
                newFolder.folderList.append(todo)
            }
        }
    }
    
    func deleteFolder(_ data: Folder) {
        try! realm.write {
            realm.delete(data)
        }
    }
}
