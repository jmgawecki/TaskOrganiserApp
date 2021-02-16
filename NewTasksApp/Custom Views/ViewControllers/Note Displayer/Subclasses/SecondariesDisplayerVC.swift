//
//  SecondariesDisplayerVC.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

// MARK: - Protocols and Delegates


protocol SecondariesDisplayerDelegate: class {
    func didMoveNoteToPriorities(with indexPath: IndexPath, back previousVC: SecondariesVC)
    func didDeleteNoteFromSecondaries(with indexPath: IndexPath, back previousVC: SecondariesVC)
}

final class SecondariesDisplayerVC: TaskDisplayerVC {
    // MARK: - Declarations
    
    
    weak var prioritiesDisplayerDelegate:   SecondariesDisplayerDelegate!
    weak var prioritiesEditorDelegates:     SecondariesEditorVCDelegatesForSecondariesVC!
    
    var previousVC: SecondariesVC!
    var indexPath:  IndexPath!
    
    
    // MARK: - Overrides

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureDeleteButton()
        configureMoveToAButton()
        configureEditButton()
    }
    

    // MARK: - @Objectives
    
    
    @objc func doneDeleteButtonTapped() {
        prioritiesDisplayerDelegate.didDeleteNoteFromSecondaries(with: indexPath, back: previousVC)
    }
    
    
    @objc func moveToSecondariesButtonTapped() {
        prioritiesDisplayerDelegate.didMoveNoteToPriorities(with: indexPath, back: previousVC)
    }
    
    
    @objc func editButtonTapped() {
        let editTaskVC                                                 = SecondariesEditorVC()
        editTaskVC.secondariesEditorToSecondariesVCDelegate            = prioritiesEditorDelegates
        editTaskVC.secondariesEditorToSecondariesDisplayerVCDelegate   = self
        editTaskVC.taskTitleTextField.text                             = titleNoteLbl.text
        editTaskVC.taskBodyTextView.text                               = taskBodyTxtV.text
        editTaskVC.indexPath                                           = indexPath
        
        let navbar = UINavigationController(rootViewController: editTaskVC)
        present(navbar, animated: true)
    }
    
    
    // MARK: - Configuration

    
    func configureDeleteButton() {
        doneDeleteBtn.addTarget(self, action: #selector(doneDeleteButtonTapped), for: .touchUpInside)
    }
    
    
    private func configureMoveToAButton() {
        moveToABBtn.setTitle("to Piorities", for: .normal)
        moveToABBtn.addTarget(self, action: #selector(moveToSecondariesButtonTapped), for: .touchUpInside)
    }
    
    
    private func configureEditButton() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
}


// MARK: - Extensions

extension SecondariesDisplayerVC: SecondariesEditorVCDelegatesForSecondariesDisplayerVC {
    func displayChangedTitleAndNoteInSecondariesDisplayer(title: String, note: String?) {
        titleNoteLbl.text       = title
        taskBodyTxtV.text       = note
    }
}
