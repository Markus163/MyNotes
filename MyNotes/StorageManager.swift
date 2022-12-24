//
//  StorageManager.swift
//  MyNotes
//
//  Created by Марк Михайлов on 23.12.2022.
//

import RealmSwift

let realm = try! Realm()

class StorageManager {
    
    static func saveObject(_ note: Note) {
        try! realm.write {
            realm.add(note)
        }
    }
    static func deleteObject(_ note: Note) {
        try! realm.write {
            realm.delete(note)
        }
    }
}
