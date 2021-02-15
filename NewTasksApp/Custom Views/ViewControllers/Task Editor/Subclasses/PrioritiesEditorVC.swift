//
//  PrioritiesVC.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 26/12/2020.
//

import UIKit

//MARK: - Protocols and Delegates


/// Delegate used in Priorities VC. Delegate executed when @editTaskButtonTapped  to update UserDefault' notes and the collectionView
protocol PrioritiesEditorVCDelegatesForPrioritiesVC: class {
    func uploadEditedTaskToDefaults(indexPath: IndexPath, title: String, note: String?)
}


/// Protocol used in PrioritiesDisplayerVC. Delegate executed when @editTaskButtonTapped to display correct Title and Note after dismissing that VC
protocol PrioritiesEditorVCDelegatesForPrioritiesDisplayerVC: class {
    func displayChangedTitleAndNoteInPrioritiesDisplayer(title: String, note: String?)
}


final class PrioritiesEditorVC: TasksEditorVC {
    //MARK: - Declarations
    
    
    var prioritiesEditorToPrioritiesVCDelegate:           PrioritiesEditorVCDelegatesForPrioritiesVC!
    var prioritiesEditorToPrioritiesDisplayerVCDelegate:  PrioritiesEditorVCDelegatesForPrioritiesDisplayerVC!
    var indexPath:  IndexPath!
    
    
    // MARK: - Overrides

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureEditButton()
    }
    
    
    // MARK: - @Objectives

    @objc func editTaskButtonTapped() {
        guard !taskTitleTextField.text!.isEmpty else { return }
        let titleText   = taskTitleTextField.text!
        let noteText    = taskBodyTextView.text
        prioritiesEditorToPrioritiesVCDelegate.uploadEditedTaskToDefaults(indexPath: indexPath, title: titleText, note: noteText)
        prioritiesEditorToPrioritiesDisplayerVCDelegate.displayChangedTitleAndNoteInPrioritiesDisplayer(title: titleText, note: noteText)
        dismiss(animated: true)
    }
    
    
    // MARK: - Configurations

    
    private func configureEditButton() { editTaskButton.addTarget(self, action: #selector(editTaskButtonTapped), for: .touchUpInside) }
}
