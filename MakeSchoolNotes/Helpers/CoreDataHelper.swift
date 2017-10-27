//
//  CoreDataHelper.swift
//  MakeSchoolNotes
//
//  Created by STH on 2017/6/21.
//  Copyright © 2017年 MakeSchool. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataHelper
{
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    static let persistentContainer = appDelegate.persistentContainer
    static let managedContext = persistentContainer.viewContext
    //static methods will go here
    
    // Create Note by CoreData
    static func newNote() -> Note
    {
        let note = NSEntityDescription.insertNewObject(forEntityName: "Note", into: managedContext) as! Note
        return note
    }
    
    // Save Note by CoreData
    static func saveNote()
    {
        do
        {
            try managedContext.save()
        }
        catch let error as NSError
        {
            print("Could not save \(error)")
        }
    }
    
    // Delete Note
    static func deleteNote(note: Note)
    {
        managedContext.delete(note)
        saveNote()
    }
    
    // Retrive Note
    static func retrieveNotes() -> [Note]
    {
        let fetchRequest = NSFetchRequest<Note>(entityName: "Note")
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            return results
        }
        catch let error as NSError
        {
            print("Could not fetch \(error)")
        }
        return []
    }
}
