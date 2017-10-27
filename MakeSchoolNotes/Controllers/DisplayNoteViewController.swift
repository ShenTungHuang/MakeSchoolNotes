//
//  DisplayNoteViewController.swift
//  MakeSchoolNotes
//
//  Created by Chris Orcutt on 1/10/16.
//  Copyright © 2016 MakeSchool. All rights reserved.
//

import UIKit

class DisplayNoteViewController: UIViewController
{
    @IBOutlet weak var noteTitleTextField: UITextField!
    @IBOutlet weak var noteContentTextView: UITextView!
    
    //create a note property
    var note: Note?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
 
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let identifier = segue.identifier
        {
            if identifier == "Cancel"
            {
                print("Cancel button tapped")
            }
            else if identifier == "Save"
            {
                // if note exists, update title and content
                let note = self.note ?? CoreDataHelper.newNote()
                note.title = noteTitleTextField.text ?? ""
                note.content = noteContentTextView.text ?? ""
                note.modificationTime = Date().convertToString()// as NSDate
                CoreDataHelper.saveNote()
                
                //create an instance of Note
                //let note = Note()
                //setting the note's title and content to the text contained
                //note.title = noteTitleTextField.text ?? ""
                //note.content = noteContentTextView.text
                //setting the note's modification time to the current time
                //note.modificationTime = Date()
                //let listNotesTableViewController = segue.destination as! ListNotesTableViewController
                //listNotesTableViewController.notes.append(note)
                
                //let listNotesTableViewController = segue.destination as! ListNotesTableViewController
                //if let note = note
                //{
                //    // 1
                //    note.title = noteTitleTextField.text ?? ""
                //    note.content = noteContentTextView.text ?? ""
                //    // 2
                //    listNotesTableViewController.tableView.reloadData()
                //}
                //else
                //{
                //    // 3
                //    let newNote = Note()
                //    newNote.title = noteTitleTextField.text ?? ""
                //    newNote.content = noteContentTextView.text ?? ""
                //    newNote.modificationTime = Date()
                //    listNotesTableViewController.notes.append(newNote)
                //}
                
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        // 1
        if let note = note
        {
            // 2
            noteTitleTextField.text = note.title
            noteContentTextView.text = note.content
        }
        else
        {
            // 3
            noteTitleTextField.text = ""
            noteContentTextView.text = ""
        }
    }
}
    
