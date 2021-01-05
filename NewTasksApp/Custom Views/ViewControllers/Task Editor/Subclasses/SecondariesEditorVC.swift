//
//  TaskBEditorVC.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 26/12/2020.
//

import UIKit

/// Delegate used in SecondariesVC. Delegate executed when @editTaskButtonTapped to update UserDefault' notes and the collectionView
protocol SecondariesEditorVCDelegatesForSecondariesVC: class {
    func uploadEditedTaskToDefaults(indexPath: IndexPath, title: String, note: String?)
}

/// Protocol used in SecondariesDisplayerVC. Delegate executed when @editTaskButtonTapped  to display correct Title and Note after dismissing that VC
protocol SecondariesEditorVCDelegatesForSecondariesDisplayerVC: class {
    func displayChangedTitleAndNoteInSecondariesDisplayer(title: String, note: String?)
}

class SecondariesEditorVC: TasksEditorVC {
    
    var secondariesEditorToSecondariesVCDelegate:           SecondariesEditorVCDelegatesForSecondariesVC!
    var secondariesEditorToSecondariesDisplayerVCDelegate:  SecondariesEditorVCDelegatesForSecondariesDisplayerVC!
    var indexPath:  IndexPath!
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEditButton()
    }

    
    // MARK: - @objc Functions
    
    @objc func editTaskButtonTapped() {
        guard !taskTitleTextField.text!.isEmpty else { return }
        let titleText   = taskTitleTextField.text!
        let noteText    = taskBodyTextView.text
        secondariesEditorToSecondariesVCDelegate.uploadEditedTaskToDefaults(indexPath: indexPath, title: titleText, note: noteText)
        secondariesEditorToSecondariesDisplayerVCDelegate.displayChangedTitleAndNoteInSecondariesDisplayer(title: titleText, note: noteText)
        dismiss(animated: true)
    }
    
    
    // MARK: - Configurations

    private func configureEditButton() {
        editTaskButton.addTarget(self, action: #selector(editTaskButtonTapped), for: .touchUpInside)
    }
}
