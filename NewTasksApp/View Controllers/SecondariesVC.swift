//
//  SecondariesVC.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

final class SecondariesVC: UIViewController {
    // MARK: - Declarations
    

    enum Section { case main }
    
    let addNoteButton   = NoteButton(backgroundColor: .systemOrange, fontSize: 20, with: "Add a task")
    var collectionView: UICollectionView!
    var dataSource:     UICollectionViewDiffableDataSource<Section, Note>!
    
    var notes:          [Note] = []
    var noteBIndex      = 1

    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureAddNoteButton()
        configureCollectionView()
        configureDataSource()
        getNotes()
        updateData(on: notes)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNotes()
        updateData(on: notes)
    }
    
    
    //MARK: - @Objectives
    
    @objc func addNoteButtonTapped() {
        let addTaskB        = AddSecondaryTaskVC()
        addTaskB.delegate   = self
        let navbar          = UINavigationController(rootViewController: addTaskB)
        present(navbar, animated: true)
    }
    
    
    //MARK: - Configuration
    
    private func configureVC() {
        view.backgroundColor                                    = .systemBackground
        let largeTitleBasedOnScreenSize: Bool                   = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? false : true
        navigationController?.navigationBar.prefersLargeTitles  = largeTitleBasedOnScreenSize
    }
    
    
    // MARK: - Persistence Manager functions
    
    
    private func getNotes() {
        PersistenceManager.retreiveNotes(for: .secondaries) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .success(let notes):
                self.notes = notes
                
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                    self.view.bringSubviewToFront(self.collectionView)
                }
                
            case .failure(_):
                return
            }
        }
    }
    
    
    // MARK: - Collection View configuration
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Note>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, notes) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCell.reuseId, for: indexPath) as! NoteCell
            cell.set(with: notes.title)
            return cell
        })
    }
    
    
    private func updateData(on Notes: [Note]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Note>()
        snapshot.appendSections([.main])
        snapshot.appendItems(notes)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createOneColumnCollectionViewFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor  = .systemBackground
        collectionView.delegate         = self
        
        collectionView.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.reuseId)
        
        let bottomConstraint: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -10 : -20
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint         (equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint     (equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint    (equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint      (equalTo: addNoteButton.topAnchor, constant: bottomConstraint)
        ])
    }
    
    
    // MARK: - Layout configurations
    
    
    private func configureAddNoteButton() {
        view.addSubview(addNoteButton)
        
        addNoteButton.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
        
        let bottomConstraint: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -10 : -20
        
        NSLayoutConstraint.activate([
            addNoteButton.leadingAnchor.constraint      (equalTo: view.leadingAnchor, constant: 22),
            addNoteButton.bottomAnchor.constraint       (equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottomConstraint),
            addNoteButton.heightAnchor.constraint       (equalToConstant: 50),
            addNoteButton.trailingAnchor.constraint     (equalTo: view.trailingAnchor, constant: -22)
        ])
    }
}

// MARK: - Extensions


extension SecondariesVC: UICollectionViewDelegate {
    /// Pushes to SecondariesDisplayerVC with the passed parameters from the CollectionViewCell to disply the whole note
    /// - Parameters:
    ///   - collectionView: collectionViewConfigured above
    ///   - indexPath: indexPath used to find title and the body of the note in note array of type Note
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let note                                = indexPath.item
        let destVC                              = SecondariesDisplayerVC()
        destVC.indexPath                        = indexPath
        destVC.prioritiesDisplayerDelegate      = self
        destVC.prioritiesEditorDelegates        = self
        destVC.previousVC                       = self
        destVC.titleNoteLbl.text                = notes[note].title
        destVC.taskBodyTxtV.text                = notes[note].note
        navigationController?.pushViewController(destVC, animated: true)
    }
}


extension SecondariesVC: AddSecondaryTaskDelegates {
    /// Adds a note to UserDefault created in AddSecondaryTaskVC and updates the collection view.
    /// - Parameters:
    ///   - titled: title for the note passed on in AddSecondaryTaskVC
    ///   - note: body for the note passed on in AddSecondaryTaskVC
    func didAddSecondaryTask(titled: String, with note: String?) {
        let note = Note(title: titled, note: note, noteId: UUID().uuidString)
        PersistenceManager.updateWith(note: note, actionType: .add, keyObject: .secondaries) { (error) in }
        getNotes()
        updateData(on: notes)
    }
}


extension SecondariesVC: SecondariesDisplayerDelegate {
    /// Moves note from UserDefault's Secondaries to Priorities. Will update data on collection view in SecondariesVC. PrioritiesVC will update when view will appear
    /// - Parameters:
    ///   - indexPath: indexPath of the note that UserDefaults' data and local array of notes of type Note share
    ///   - previousVC: taking you back to that VC
    func didMoveNoteToPriorities(with indexPath: IndexPath, back previousVC: SecondariesVC) {
        let note = notes[indexPath.item]
        PersistenceManager.moveNote(note: note, fromTo: .fromSecondariesToPriorities) { (error) in }
        navigationController?.popViewController(animated: true)
    }
    
    
    /// Deletes the note from UserDefaults Secondaries
    /// - Parameters:
    ///   - indexPath: indexPath of the note that UserDefaults' data and local array of notes of type Note share
    ///   - previousVC: taking you back to that VC
    func didDeleteNoteFromSecondaries(with indexPath: IndexPath, back previousVC: SecondariesVC) {
        navigationController?.popToViewController(previousVC, animated: true)
        PersistenceManager.updateWith(note: notes[indexPath.item], actionType: .remove, keyObject: .secondaries) { (error) in }
        notes.remove(at: indexPath.item)
        updateData(on: notes)
    }
}


extension SecondariesVC: SecondariesEditorVCDelegatesForSecondariesVC {
    /// Edit the task based on passed title and note in SecondariesEditorVC with the indexPath of the note
    /// - Parameters:
    ///   - indexPath: indexPath of the note that UserDefaults' data and local array of notes of type Note share
    ///   - title: title for the note passed on in SecondariesEditorVC
    ///   - note: body for the note passed on in SecondariesEditorVC
    func uploadEditedTaskToDefaults(indexPath: IndexPath, title: String, note: String?) {
        notes[indexPath.item].title     = title
        notes[indexPath.item].note      = note
        updateData(on: notes)
        let _ = PersistenceManager.saveNotes(notes: notes, for: .secondaries)
    }
}
