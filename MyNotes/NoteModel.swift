//
//  NoteModel.swift
//  MyNotes
//
//  Created by Марк Михайлов on 22.12.2022.
//

import RealmSwift

class Note: Object {
    
    @objc dynamic var titleText: String = "Hello! It's your first note."
    
    convenience init(titleText: String) {
        self.init()
        self.titleText = titleText
    }
    
    let notesArray = ["Hello! It's your first note."]
    
    func saveNotes() {
                
        for note in notesArray {
            let newNote = Note()
            newNote.titleText = note
            StorageManager.saveObject(newNote)
        }
    }
    
}

