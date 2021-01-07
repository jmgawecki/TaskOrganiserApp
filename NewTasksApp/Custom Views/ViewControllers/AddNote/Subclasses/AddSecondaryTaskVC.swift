//
//  AddTaskBVC.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

/// Delegates used in SecondariesVC. Executed when @addTaskButtonTapped. Add a note to Secondaries UserDefault and update the collection view. Dismiss the currect VC
protocol AddSecondaryTaskDelegates: class {
    func didAddSecondaryTask(titled: String, with note: String?)
}


class AddSecondaryTaskVC: AddTaskVC {
    
    weak var delegate: AddSecondaryTaskDelegates!
    
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
        delegate.didAddSecondaryTask(titled: taskTitle, with: taskBody)
        dismiss(animated: true)
    }
    
    
    // MARK: - Configurations

    private func configureVC() {
        title                       = "Add a Secondary task"
        taskTitleTextField.delegate = self
    }
    
    private func configureAddTaskButton() {
        addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
    }
}


// MARK: - Extensions

extension AddSecondaryTaskVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
            return false
    }
}
