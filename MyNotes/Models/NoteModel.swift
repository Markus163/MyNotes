//
//  NoteModel.swift
//  MyNotes
//
//  Created by Марк Михайлов on 22.12.2022.
//

import RealmSwift

class Note: Object {
    
    @objc dynamic var titleText: String = ""
    
    convenience init(titleText: String) {
        self.init()
        self.titleText = titleText
    }
}

