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
    @IBAction func savePressed(_ sender: Any) {
    }
    
    @IBAction func noteTextPressed(_ sender: Any) {

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        noteText.delegate = self
        saveButton.isEnabled = false
        noteText.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        setupEditScreen()

    }
    
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension NoteViewController: UITextFieldDelegate {
    @objc private func textFieldChanged() {
        
        if noteText.text?.isEmpty == false {
            saveButton.isEnabled = true
        } else {
            saveButton.isEnabled = false
        }
        
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
