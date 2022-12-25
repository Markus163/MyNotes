//
//  MainTableViewController.swift
//  MyNotes
//
//  Created by Марк Михайлов on 22.12.2022.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {
    
    let realm = try! Realm()
    lazy var notes: Results<Note> = { self.realm.objects(Note.self) }()
    var currentNote: Note?
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNote()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.isEmpty ? 0 : notes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NoteTableViewCell

        let note = notes[indexPath.row]
        cell.titleLabel?.text = note.titleText
        return cell
    }
    
    func firstNote() {
        if notes.count == 0 {
         try! realm.write() {
            let newNote = Note()
              newNote.titleText = "It's your first note!"
            self.realm.add(newNote)
        }
          notes = realm.objects(Note.self)
      }
    }

    // MARK: - Table view delegate

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = notes[indexPath.row]
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (_, view, _) in
            StorageManager.deleteObject(note)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
            return swipeActions
        }
    
     //MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            let note = notes[indexPath.row]
            let noteVC = segue.destination as! NoteViewController
            noteVC.currentNote = note
        }
    }
    
    @IBAction func unwindSegue(_ segue: UIStoryboardSegue) {
        
        guard let newNoteVC = segue.source as? NoteViewController else { return }
        newNoteVC.saveNote()
        tableView.reloadData()
    }
}
