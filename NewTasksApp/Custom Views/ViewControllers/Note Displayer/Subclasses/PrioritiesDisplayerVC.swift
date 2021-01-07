//
//  PrioritiesDisplayerVC.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit


/// Delegates used in Priorities VC
/// didMoveNoteToSecondaries executed when @moveToABButtonTapped. Moves note from Priorities to Secondaries in UserDefaults
/// didDeleteNoteFromPriorities executed when @doneDeleteButtonTapped. Delete that note from UserDefault and update the collection View
protocol PrioritiesDisplayerDelegate: class {
    func didMoveNoteToSecondaries(with indexPath: IndexPath, back previousVC: PrioritiesVC)
    func didDeleteNoteFromPriorities(with indexPath: IndexPath, back previousVC: PrioritiesVC)
}


class PrioritiesDisplayerVC: TaskDisplayerVC {
    
    weak var prioritiesDisplayerDelegate:   PrioritiesDisplayerDelegate!
    weak var prioritiesEditorDelegates:     PrioritiesEditorVCDelegatesForPrioritiesVC!
    
    var previousVC:             PrioritiesVC!
    var indexPath:              IndexPath!
    
    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        configureEditButton()
        configureMoveToSecondariesButton()
        configureDeleteButton()
    }

    
    // MARK: - @objc Functions
    
    @objc func doneDeleteButtonTapped() {
        prioritiesDisplayerDelegate.didDeleteNoteFromPriorities(with: indexPath, back: previousVC)
    }
    
    
    @objc func moveToSecondariesButtonTapped() {
        prioritiesDisplayerDelegate.didMoveNoteToSecondaries(with: indexPath, back: previousVC)
    }
    
    
    @objc func editButtonTapped() {
        let editTaskVC                                              = PrioritiesEditorVC()
        editTaskVC.prioritiesEditorToPrioritiesVCDelegate           = prioritiesEditorDelegates
        editTaskVC.prioritiesEditorToPrioritiesDisplayerVCDelegate  = self
        editTaskVC.taskTitleTextField.text                          = titleNoteLabel.text
        editTaskVC.taskBodyTextView.text                            = taskBodyTextView.text
        editTaskVC.indexPath                                        = indexPath
        
        let navbar = UINavigationController(rootViewController: editTaskVC)
        present(navbar, animated: true)
    }

    
    // MARK: - Configurations
    
    func configureDeleteButton() {
        doneDeleteButton.addTarget(self, action: #selector(doneDeleteButtonTapped), for: .touchUpInside)
    }
    
    
    private func configureMoveToSecondariesButton() {
        moveToABButton.setTitle(" to Secondaries ", for: .normal)
        moveToABButton.addTarget(self, action: #selector(moveToSecondariesButtonTapped), for: .touchUpInside)
    }
    
    
    private func configureEditButton() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
}


// MARK: - Extensions

extension PrioritiesDisplayerVC: PrioritiesEditorVCDelegatesForPrioritiesDisplayerVC {
    func displayChangedTitleAndNoteInPrioritiesDisplayer(title: String, note: String?) {
        titleNoteLabel.text         = title
        taskBodyTextView.text       = note
    }
}
