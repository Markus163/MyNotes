//
//  MainTableViewController.swift
//  MyNotes
//
//  Created by Марк Михайлов on 22.12.2022.
//

import UIKit
import RealmSwift

class MainTableViewController: UITableViewController {
    
    var notes: Results<Note>!
    //var notes = [Note(titleText: "Hello! It's your first note.")]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        notes = realm.objects(Note.self)

       
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.isEmpty ? 0 : notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NoteTableViewCell

        let note = notes[indexPath.row]
        cell.titleLabel?.text = note.titleText
        //cell.subtitleLabel?.text = notes[indexPath.row].subtitleText
        return cell
    }


    // MARK: - Table view delegate
    //override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let note = notes[indexPath.row]
        let contextItem = UIContextualAction(style: .destructive, title: "Delete") {  (_, view, _) in
            StorageManager.deleteObject(note)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
            return swipeActions
        }
    
//    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//
//       let note = notes[indexPath.row]
//       let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (_, _) in
//           StorageManager.deleteObject(note)
//           tableView.deleteRows(at: [indexPath], with: .automatic)
//       }
//       return [deleteAction]
//   }
    
    
    
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
        //notes.append(newNoteVC.newNote!)
        tableView.reloadData()
    }
}
