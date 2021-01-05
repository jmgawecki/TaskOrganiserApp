//
//  AddTaskAVC.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

/// Delegates used in PrioritiesVC. Executed when @addTaskButtonTapped. Add a note to Priorities UserDefault and update the collction view. Dismiss the currect VC
protocol AddPriorityTaskDelegates: class {
    func didAddPriorityTask(titled: String, with note: String?)
}

class AddPriorityTaskVC: AddTaskVC {
    
    weak var delegate: AddPriorityTaskDelegates!
    
    var indexPath: IndexPath!
    
    
    // MARK: - Overrides
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
    }

    
    // MARK: - @objc Functions
    
    override func addTaskButtonTapped() {
        guard !taskTitleTextField.text!.isEmpty else { return }
        let taskTitle   = taskTitleTextField.text!
        let taskBody    = taskBodyTextView.text
        delegate.didAddPriorityTask(titled: taskTitle, with: taskBody)
        dismiss(animated: true)

    }
    
    
    // MARK: - Configurations

    private func configureVC() {
        title                       = "Add a Priority task"
        taskTitleTextField.delegate = self
    }
    
    
    private func configureAddTaskButton() {
        addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
    }
}


// MARK: - Extensions

extension AddPriorityTaskVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
            return false
    }
}
