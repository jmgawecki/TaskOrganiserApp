//
//  PrioritiesDisplayerVC.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

// MARK: - Protocols and Delegates


protocol PrioritiesDisplayerDelegate: class {
    func didMoveNoteToSecondaries(with indexPath: IndexPath, back previousVC: PrioritiesVC)
    func didDeleteNoteFromPriorities(with indexPath: IndexPath, back previousVC: PrioritiesVC)
}


final class PrioritiesDisplayerVC: TaskDisplayerVC {
    // MARK: - Declarations
    
    
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

    
    // MARK: - @Objectives
    
    
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
        editTaskVC.taskTitleTextField.text                          = titleNoteLbl.text
        editTaskVC.taskBodyTextView.text                            = taskBodyTxtV.text
        editTaskVC.indexPath                                        = indexPath
        
        let navbar = UINavigationController(rootViewController: editTaskVC)
        present(navbar, animated: true)
    }

    
    // MARK: - Configuration
    
    
    func configureDeleteButton() { doneDeleteBtn.addTarget(self, action: #selector(doneDeleteButtonTapped), for: .touchUpInside) }
    
    
    private func configureMoveToSecondariesButton() {
        moveToABBtn.setTitle(" to Secondaries ", for: .normal)
        moveToABBtn.addTarget(self, action: #selector(moveToSecondariesButtonTapped), for: .touchUpInside)
    }
    
    
    private func configureEditButton() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
}


// MARK: - Extensions


extension PrioritiesDisplayerVC: PrioritiesEditorVCDelegatesForPrioritiesDisplayerVC {
    func displayChangedTitleAndNoteInPrioritiesDisplayer(title: String, note: String?) {
        titleNoteLbl.text         = title
        taskBodyTxtV.text       = note
    }
}
