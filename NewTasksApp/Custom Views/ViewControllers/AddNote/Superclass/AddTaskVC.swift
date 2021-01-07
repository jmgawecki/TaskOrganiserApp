//
//  AddTaskVC.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

class AddTaskVC: UIViewController {
    
    let taskTitleTextField  = TitleTextField(frame: .zero)
    let taskBodyTextView    = NoteTextView(frame: .zero)
    let addTaskButton       = NoteButton(backgroundColor: .systemGreen, fontSize: 20, with: "Add Task!")

    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureLayout()
        configureAddTaskButton()
        configureTaskBodyTextView()
        adjustTextViewLayoutToKeyboard()
    }
    
    
    // MARK: - @objc Functions
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue     = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardScreenEndFrame  = keyboardValue.cgRectValue
        let keyboardViewEndFrame    = view.convert(keyboardScreenEndFrame, from: view.window)
        let buttonValue             = addTaskButton.frame.height
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            taskBodyTextView.contentInset = .zero
        } else {
            taskBodyTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom - buttonValue, right: 0)
        }
        
        taskBodyTextView.scrollIndicatorInsets  = taskBodyTextView.contentInset
        let selectedRange                       = taskBodyTextView.selectedRange
        taskBodyTextView.scrollRangeToVisible(selectedRange)
    }
    
    @objc func cancelButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc func addTaskButtonTapped() {
        /// Override in subclasses
    }
    
    
    // MARK: - Configurations

    private func configureVC() {
        navigationController?.navigationBar.prefersLargeTitles  = false
        navigationItem.rightBarButtonItem                       = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        view.backgroundColor                                    = .systemBackground
    }
    
    private func configureAddTaskButton() {
        addTaskButton.addTarget(self, action: #selector(addTaskButtonTapped), for: .touchUpInside)
    }
    
    
    private func configureTaskBodyTextView() {
        taskBodyTextView.isEditable = true
    }
    

    private func adjustTextViewLayoutToKeyboard() {
        let notificationCenter = NotificationCenter.default
        
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }
    // MARK: - Layout configurations
    
    private func configureLayout() {
        view.addSubview(taskTitleTextField)
        view.addSubview(taskBodyTextView)
        view.addSubview(addTaskButton)
        
        taskBodyTextView.configureKeyboardToolbar(in: taskBodyTextView)
        
        let topTitleConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 10 : 20
        let topTaskBodyConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 0 : 20

        
        let padding: CGFloat = 20
        
        NSLayoutConstraint.activate([
            taskTitleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topTitleConstraintConstant),
            taskTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            taskTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            taskTitleTextField.heightAnchor.constraint(equalToConstant: 50),
            
            addTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            addTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            addTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            addTaskButton.heightAnchor.constraint(equalToConstant: 50),
            
            taskBodyTextView.topAnchor.constraint(equalTo: taskTitleTextField.bottomAnchor, constant: topTaskBodyConstraintConstant),
            taskBodyTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            taskBodyTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            taskBodyTextView.bottomAnchor.constraint(equalTo: addTaskButton.topAnchor, constant: -padding),
        ])
    }
}

