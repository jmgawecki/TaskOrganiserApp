//
//  TaskEditorVC.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 26/12/2020.
//

import UIKit

class TasksEditorVC: UIViewController {
    //MARK: - Declarations
    
    
    let taskTitleTextField  = TitleTextField(frame: .zero)
    let taskBodyTextView    = NoteTextView(frame: .zero)
    let editTaskButton      = NoteButton(backgroundColor: .systemGreen, fontSize: 20, with: "Edit Task!")
    
    
    // MARK: - Overrides

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureLayout()
        adjustTextViewLayoutToKeyboard()
    }

    
    // MARK: - @Objectives

    
    @objc func cancelButtonTapped() { dismiss(animated: true) }
    
    
    @objc func adjustForKeyboard(notification: Notification) {
        guard let keyboardValue     = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame  = keyboardValue.cgRectValue
        let keyboardViewEndFrame    = view.convert(keyboardScreenEndFrame, from: view.window)
        let buttonValue             = editTaskButton.frame.height
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            taskBodyTextView.contentInset = .zero
        } else {
            taskBodyTextView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom - buttonValue, right: 0)
        }
        
        taskBodyTextView.scrollIndicatorInsets  = taskBodyTextView.contentInset
        let selectedRange                       = taskBodyTextView.selectedRange
        taskBodyTextView.scrollRangeToVisible(selectedRange)
    }
   
    
    // MARK: - VC Configuration
    
    
    private func adjustTextViewLayoutToKeyboard() {
        let notificationCenter = NotificationCenter.default
       
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(adjustForKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
    }

    
    private func createDismissKeyboardTapGestureRecogniser() {
        let tap = UITapGestureRecognizer(target: view.self, action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    
    private func configureTaskBodyTextView() { taskBodyTextView.isEditable = true }
    
    
    private func configureVC() {
        navigationItem.rightBarButtonItem   = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        view.backgroundColor                = .systemBackground
        title                               = "Edit Task"
        createDismissKeyboardTapGestureRecogniser()
    }
    
    
    // MARK: - Layout configuration

    private func configureLayout() {
        view.addSubview(taskTitleTextField)
        view.addSubview(editTaskButton)
        view.addSubview(taskBodyTextView)
        
        taskBodyTextView.configureKeyboardToolbar(in: taskBodyTextView)
 
        let padding: CGFloat = 30
        
        let titleTopConstraintConstant: CGFloat     = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 10 : 30
        let taskBodyTopConstraintConstant: CGFloat  = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 5 : 30
        
        NSLayoutConstraint.activate([
            
            taskTitleTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: titleTopConstraintConstant),
            taskTitleTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            taskTitleTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            taskTitleTextField.heightAnchor.constraint(equalToConstant: 40),
            
            editTaskButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            editTaskButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            editTaskButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            editTaskButton.heightAnchor.constraint(equalToConstant: 50),
            
            taskBodyTextView.topAnchor.constraint(equalTo: taskTitleTextField.bottomAnchor, constant: taskBodyTopConstraintConstant),
            taskBodyTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            taskBodyTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            taskBodyTextView.bottomAnchor.constraint(equalTo: editTaskButton.topAnchor, constant: -20),
        ])
    }
}
