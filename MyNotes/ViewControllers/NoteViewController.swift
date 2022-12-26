//
//  NoteViewController.swift
//  MyNotes
//
//  Created by Марк Михайлов on 22.12.2022.
//

import UIKit

class NoteViewController: UIViewController {
    
    var currentNote: Note?
    
    @IBOutlet weak var noteText: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func savePressed(_ sender: Any) {}
    @IBAction func noteTextPressed(_ sender: Any) {}
    
    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNoteVC()
        setupEditScreen()
    }
    
    //MARK: - Methods
    func saveNote() {
        let newNote = Note(titleText: noteText.text!)
        if currentNote != nil {
            try! realm.write {
                currentNote?.titleText = newNote.titleText
            }
        } else {
            StorageManager.saveObject(newNote)
        }
    }
    
    private func setupNoteVC() {
        noteText.delegate = self
        saveButton.isEnabled = false
        noteText.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    private func setupEditScreen() {
        if currentNote != nil {
            setupNavigationBar()
            noteText.text = currentNote?.titleText
        }
    }
    
    private func setupNavigationBar() {
        if let topItem = navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }
        saveButton.isEnabled = true
    }
}

extension NoteViewController: UITextFieldDelegate {
    @objc private func textFieldChanged() {
        if noteText.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
    }
    
    internal func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
