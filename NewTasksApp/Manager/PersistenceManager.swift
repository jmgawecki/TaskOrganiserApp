//
//  PersistenceManager.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit


/// Determines path that the note is going to take. Passed on in PersistenceManager.moveNote
enum FromTo: String {
    case fromPrioritiesToSecondaries = "fromPrioritiesToSecondaries"
    case fromSecondariesToPriorities = "fromSecondariesToPriorities"
}


/// Determines UserDefault's keyObjects. Passed on in:
/// PersistenceManager.updateWith
/// PersistenceManager.retrieveNotes
/// PersistenceManager.saveNotes
/// PersistenceManager.moveNotes
enum KeyObjects: String {
    case priorities     = "priorities"
    case secondaries    = "secondaries"
}


/// Determines wether the note is going to be removed or added. Passed on in PersistenceManager.updateWith
enum PersistenceActionType { case add, remove }

enum PersistenceManager {
    
    static let defaults = UserDefaults.standard
    
    
    /// Updates UserDefaults with the KeyObject
    /// - Parameters:
    ///   - note: Note created in TasksEditor's subclass
    ///   - actionType: Determines wether the note that is passed is going to be added or removed
    ///   - keyObject: Determine wether note is saved in Priorities or Secondaries
    ///   - completed: Optional error
    static func updateWith(note: Note, actionType: PersistenceActionType, keyObject: KeyObjects, completed: @escaping(Error?) -> Void) {
        retreiveNotes(for: keyObject) { (result) in
            switch result {
            case .success(var retrievedNotes):
                switch actionType {
                case .add:
                    retrievedNotes.append(note)
                    
                case .remove:
                    retrievedNotes.removeAll() { $0.noteId == note.noteId}
                }
                completed(saveNotes(notes: retrievedNotes, for: keyObject))
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    
    /// Retrieves array of notes of type Note from UserDefaults
    /// - Parameters:
    ///   - tasks: determines wether the note is retreived from Priorities or Secondaries
    ///   - completed: Completion with the retreived array of notes of type Note upon success or eventual Error upon failure
    static func retreiveNotes(for tasks: KeyObjects, completed: @escaping(Result<[Note], CustomErrors>) -> Void) {
        switch tasks {
        case .priorities:
            guard let noteData = defaults.object(forKey: tasks.rawValue) as? Data else {
                completed(.success([]))
                return
            }
            do {
                let decoder = JSONDecoder()
                let notes   = try decoder.decode([Note].self, from: noteData)
                completed(.success(notes))
            } catch {
                print("error in retreiveNotes PersistenceManager")
                completed(.failure(CustomErrors.unableToNotes))
            }
            
        case .secondaries:
            guard let noteData = defaults.object(forKey: tasks.rawValue) as? Data else {
                completed(.success([]))
                return
            }
            do {
                let decoder = JSONDecoder()
                let notes   = try decoder.decode([Note].self, from: noteData)
                completed(.success(notes))
            } catch {
                completed(.failure(.unableToNotes))
            }
        }
    }
    
    
    /// Save array of notes from VC into UserDefaults. Used in PersistenceManager.update with for the same purpose
    /// - Parameters:
    ///   - notes: Array of notes from VC
    ///   - task: Determines wether notes are uploaded to UserDefault's Priorites or Secondaries
    /// - Returns: Return optional error when caught in catch
    static func saveNotes(notes: [Note], for task: KeyObjects) -> CustomErrors? {
        switch task {
        case .priorities:
            do {
                let encoder = JSONEncoder()
                let notes   = try encoder.encode(notes)
                defaults.set(notes, forKey: task.rawValue)
            } catch {
                return .unableToNotes
            }
        case .secondaries:
            do {
                let encoder = JSONEncoder()
                let notes   = try encoder.encode(notes)
                defaults.set(notes, forKey: task.rawValue)
                return nil
            } catch {
                return .unableToNotes
            }
        }
        return nil
    }
    
    
    /// Function that retrieve notes from DefaultUser's specified with the key and upload passed note to specified DefaultUser
    /// - Parameters:
    ///   - note: note that is going to be moved from one UserDefault to another
    ///   - fromTo: Determines
    ///   - completed: Returns optional error... refactor errors and create an alert
    static func moveNote(note: Note, fromTo: FromTo, completed: @escaping(CustomErrors?) -> Void) {
        var prioritiesNotesData: Data
        var secondaryNotesData: Data
        
        prioritiesNotesData = defaults.object(forKey: KeyObjects.priorities.rawValue) as! Data
        secondaryNotesData  = defaults.object(forKey: KeyObjects.secondaries.rawValue) as! Data
        let decoder         = JSONDecoder()
        let encoder         = JSONEncoder()
        
        switch fromTo {
        case .fromPrioritiesToSecondaries:
            do {
                var notesFromSecondariedDecoded = try decoder.decode([Note].self, from: secondaryNotesData)
                notesFromSecondariedDecoded.append(note)
                
                let notesFromSecondariesEncoded = try encoder.encode(notesFromSecondariedDecoded)
                defaults.set(notesFromSecondariesEncoded, forKey: KeyObjects.secondaries.rawValue)
                
                
                var notesFromPrioritiesDecoded = try decoder.decode([Note].self, from: prioritiesNotesData)
                notesFromPrioritiesDecoded.removeAll() { $0.noteId == note.noteId}
                
                let notesFromPrioritiesEncoded = try encoder.encode(notesFromPrioritiesDecoded)
                defaults.set(notesFromPrioritiesEncoded, forKey: KeyObjects.priorities.rawValue)
            } catch {
                return
            }
            
        case .fromSecondariesToPriorities:
            do {
                var notesFromPrioritiesDecoded = try decoder.decode([Note].self, from: prioritiesNotesData)
                notesFromPrioritiesDecoded.append(note)
                
                let notesFromPrioritiesEncoded = try encoder.encode(notesFromPrioritiesDecoded)
                defaults.set(notesFromPrioritiesEncoded, forKey: KeyObjects.priorities.rawValue)
                
                
                var notesFromSecondariedDecoded = try decoder.decode([Note].self, from: secondaryNotesData)
                notesFromSecondariedDecoded.removeAll() { $0.noteId == note.noteId}
                
                let notesFromSecondariesEncoded = try encoder.encode(notesFromSecondariedDecoded)
                defaults.set(notesFromSecondariesEncoded, forKey: KeyObjects.secondaries.rawValue)
            } catch {
                return
            }
        }
    }
}
