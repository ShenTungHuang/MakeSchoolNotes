//
//  ListNotesTableViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit
import CoreData

class ListNotesTableViewController: UITableViewController
{
    var notes = [Note]()
    {
        didSet // be triggered whenever the property changes is triggered immediately following a property change
        {
            tableView.reloadData()
            notes.reverse()
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        notes = CoreDataHelper.retrieveNotes()
    }
    
    // answer the table view's question about how many cells it should display
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return notes.count
    }
    
    // the table view's way of asking us, "what cell should I dsplay in this particular row of the table?" We answer that question by constructing a UITableViewCell
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        /* fetching the actual cell that will be displayed in the table view */
        //let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath)
        
        // downcast the UITableViewCell returned by dequeueReusableCellWithIdentifier(_:forIndexPath:) to our custom ListNotesTableViewCell : because ListNotesTableViewCell is a subclass of UITableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "listNotesTableViewCell", for: indexPath) as! ListNotesTableViewCell
        
        // set the text property of our cell's UILabel
        //cell.textLabel?.text = "Yay - it's working!"      cell.textLabel? is default
        //cell.noteTitleLabel.text = "note's title"
        //cell.noteModificationTimeLabel.text = "note's modification time"
        

        let row = indexPath.row
        let note = notes[row]
        cell.noteTitleLabel.text = note.title
        cell.noteModificationTimeLabel.text = note.modificationTime
        cell.notecontentlabel.text = note.content
        

        return cell
    }
    
    // 1
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
    {
        if editingStyle == .delete
        {
            CoreDataHelper.deleteNote(note: notes[indexPath.row])
            notes = CoreDataHelper.retrieveNotes()
        }
    }
    
    //MARK: - override func prepare
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let identifier = segue.identifier
        {
            if identifier == "displayNote"
            {
                let indexPath = tableView.indexPathForSelectedRow!
                let note = notes[indexPath.row]
                let displayNoteViewController = segue.destination as! DisplayNoteViewController
                displayNoteViewController.note = note
            }
            else if ( identifier == "addNote" )
            {
                print("+ button tapped")
            }
        }
    }
    
    //MARK: - IBAction func unwindToListNotesViewController
    @IBAction func unwindToListNotesViewController(_ segue: UIStoryboardSegue)
    {
        self.notes = CoreDataHelper.retrieveNotes()
    }
}
