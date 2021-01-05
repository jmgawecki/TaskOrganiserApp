//
//  ViewController.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

class PrioritiesVC: UIViewController {
    
    enum Section { case main }
    
    let addNoteButton = NoteButton(backgroundColor: .systemOrange, fontSize: 20, with: "Add a task")
    
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section,Note>!
    
    var noteAIndex = 1
    var notes: [Note] = []

    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureAddNoteButton()
        configureCollectionView()
        configureDataSource()
        getNotes()
        updateData(with: notes)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getNotes()
        updateData(with: notes)
    }
    
    
    //MARK: - @objc Functions
    
    @objc func addNoteButtonTapped() {
        let addTaskVC = AddPriorityTaskVC()
        addTaskVC.delegate = self
        let navbar = UINavigationController(rootViewController: addTaskVC)
        present(navbar, animated: true)
    }
    
    
    //MARK: - Private functions
    
    private func configureVC() {
        view.backgroundColor                                    = .systemBackground
        
        let largeTitleBasedOnScreenSize: Bool                   = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? false : true
        navigationController?.navigationBar.prefersLargeTitles  = largeTitleBasedOnScreenSize
    }
    
    
    private func getNotes() {
        PersistenceManager.retreiveNotes(for: .priorities) { [weak self] (result) in
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
    
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section,Note>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, notes) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NoteCell.reuseId, for: indexPath) as! NoteCell
            cell.set(with: notes.title)
            return cell
        })
    }
    
    
    func updateData(with Notes: [Note]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Note>()
        snapshot.appendSections([.main])
        snapshot.appendItems(notes)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    
    // MARK: - Layout configurations
    
    private func configureAddNoteButton() {
        view.addSubview(addNoteButton)
        addNoteButton.addTarget(self, action: #selector(addNoteButtonTapped), for: .touchUpInside)
        
        let bottomConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -10 : -20
        
        NSLayoutConstraint.activate([
            addNoteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 22),
            addNoteButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: bottomConstraintConstant),
            addNoteButton.heightAnchor.constraint(equalToConstant: 50),
            addNoteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -22)
        ])
    }
    
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createOneColumnCollectionViewFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.backgroundColor  = .systemBackground
        collectionView.delegate         = self
        
        collectionView.register(NoteCell.self, forCellWithReuseIdentifier: NoteCell.reuseId)
        
        let bottomConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -10 : -20
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: addNoteButton.topAnchor, constant: bottomConstraintConstant)
        ])
    }
    
}


// MARK: - Extensions


extension PrioritiesVC: UICollectionViewDelegate {
    /// Pushes to PrioritiesDisplayerVC with the passed parameters from the CollectionViewCell to disply the whole note
    /// - Parameters:
    ///   - collectionView: collectionViewConfigured above
    ///   - indexPath: indexPath used to find title and the body of the note in note array of type Note
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let note                            = indexPath.item
        let destVC                          = PrioritiesDisplayerVC()
        destVC.indexPath                    = indexPath
        destVC.prioritiesDisplayerDelegate  = self
        destVC.prioritiesEditorDelegates    = self
        destVC.previousVC                   = self
        destVC.titleNoteLabel.text          = notes[note].title
        destVC.taskBodyTextView.text        = notes[note].note
        navigationController?.pushViewController(destVC, animated: true)
    }
}


extension PrioritiesVC: AddPriorityTaskDelegates {
    /// Adds a note to UserDefault created in AddPriorityTaskVC and updates the collection view.
    /// - Parameters:
    ///   - titled: title for the note passed on in AddPriorityTaskVC
    ///   - note: body for the note passed on in AddPriorityTaskVC
    func didAddPriorityTask(titled: String, with note: String?) {
        let note = Note(title: titled, note: note, noteId: UUID().uuidString)
        noteAIndex += 1
        PersistenceManager.updateWith(note: note, actionType: .add, keyObject: .priorities) { (error) in }
        getNotes()
        updateData(with: notes)
    }
}


extension PrioritiesVC: PrioritiesDisplayerDelegate {
    /// Moves note from UserDefault's Priorities to Secondaries. Will update data on collection view in PrioritiesVC. SecondariesVC will update when view will appear
    /// - Parameters:
    ///   - indexPath: indexPath of the note that UserDefaults' data and local array of notes of type Note share
    ///   - previousVC: taking you back to that VC
    func didMoveNoteToSecondaries(with indexPath: IndexPath, back previousVC: PrioritiesVC) {
        let note = notes[indexPath.item]
        PersistenceManager.moveNote(note: note, fromTo: .fromPrioritiesToSecondaries) { (error) in }
        navigationController?.popViewController(animated: true)
    }
    
    
    /// Deletes the note from UserDefaults Priorities
    /// - Parameters:
    ///   - indexPath: indexPath of the note that UserDefaults' data and local array of notes of type Note share
    ///   - previousVC: taking you back to that VC
    func didDeleteNoteFromPriorities(with indexPath: IndexPath, back previousVC: PrioritiesVC) {
        navigationController?.popToViewController(previousVC, animated: true)
        PersistenceManager.updateWith(note: notes[indexPath.item], actionType: .remove, keyObject: .priorities) { (error) in }
        notes.remove(at: indexPath.item)
        updateData(with: notes)
    }
}


extension PrioritiesVC: PrioritiesEditorVCDelegatesForPrioritiesVC {
    /// Edit the task based on passed title and note in PrioritiesEditorVC with the indexPath of the note
    /// - Parameters:
    ///   - indexPath: indexPath of the note that UserDefaults' data and local array of notes of type Note share
    ///   - title: title for the note passed on in PrioritiesEditorVC
    ///   - note: body for the note passed on in PrioritiesEditorVC
    func uploadEditedTaskToDefaults(indexPath: IndexPath, title: String, note: String?) {
        notes[indexPath.item].title = title
        notes[indexPath.item].note = note
        updateData(with: notes)
        let _ = PersistenceManager.saveNotes(notes: notes, for: .priorities)
    }
    
    
}
