//
//  MainTableViewController.swift
//  MyNotes
//
//  Created by Марк Михайлов on 22.12.2022.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var notes = [ "Hello! It's your first note."
            //"Apple Park Visit\n\nRemember to pack food for the long road trip!\n\nWe will need...\n\n- Protein Bars\n- Plently of Water\n- Apples\n\nAddress is 1 Apple Park Way"
        ]

    override func viewDidLoad() {
        super.viewDidLoad()

       
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NoteTableViewCell

        cell.titleLabel?.text = notes[indexPath.row]
        cell.subtitleLabel?.text = "31.12.2023"
        return cell
    }

    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
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
