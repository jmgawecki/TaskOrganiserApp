//
//  SecondariesDisplayerVC.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

/// Delegates used in SecondariesVC
/// didMoveNoteToPriorities executed when @moveToABButtonTapped. Moves note from Secondaries to Priorities in UserDefaults
/// didDeleteNoteFromPriorities executed when @doneDeleteButtonTapped. Delete that note from UserDefault and update the collection View
protocol SecondariesDisplayerDelegate: class {
    func didMoveNoteToPriorities(with indexPath: IndexPath, back previousVC: SecondariesVC)
    func didDeleteNoteFromSecondaries(with indexPath: IndexPath, back previousVC: SecondariesVC)
}

class SecondariesDisplayerVC: TaskDisplayerVC {
    
    
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
    

    // MARK: - @objc Functions
    
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
        editTaskVC.taskTitleTextField.text                             = titleNoteLabel.text
        editTaskVC.taskBodyTextView.text                               = taskBodyTextView.text
        editTaskVC.indexPath                                           = indexPath
        
        let navbar = UINavigationController(rootViewController: editTaskVC)
        present(navbar, animated: true)
        
    }
    
    
    // MARK: - Configurations

    func configureDeleteButton() {
        doneDeleteButton.addTarget(self, action: #selector(doneDeleteButtonTapped), for: .touchUpInside)
    }
    
    
    private func configureMoveToAButton() {
        moveToABButton.setTitle("to Piorities", for: .normal)
        moveToABButton.addTarget(self, action: #selector(moveToSecondariesButtonTapped), for: .touchUpInside)
    }
    
    
    private func configureEditButton() {
        editButton.addTarget(self, action: #selector(editButtonTapped), for: .touchUpInside)
    }
}


// MARK: - Extensions

extension SecondariesDisplayerVC: SecondariesEditorVCDelegatesForSecondariesDisplayerVC {
    func displayChangedTitleAndNoteInSecondariesDisplayer(title: String, note: String?) {
        titleNoteLabel.text = title
        taskBodyTextView.text = note
    }
}
