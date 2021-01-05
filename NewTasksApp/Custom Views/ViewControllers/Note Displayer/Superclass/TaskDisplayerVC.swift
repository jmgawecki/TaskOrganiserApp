//
//  TaskDisplayerVC.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

class TaskDisplayerVC: UIViewController {
    
    let titleNoteLabel      = TitleNoteLabel()
    let taskBodyTextView    = NoteTextView(frame: .zero)
    let editButton          = NoteButton(backgroundColor: .systemOrange, fontSize: 20, with: "Edit")
    let moveToABButton      = NoteButton(backgroundColor: .systemTeal, fontSize: 20, with: "")
    let doneDeleteButton    = NoteButton(backgroundColor: .systemGreen, fontSize: 20, with: "Mark done and delete!")

    
    // MARK: - Overrides

    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureElements()
        layoutUI()
        configureTaskBodyTextView()
    }
    
    
    // MARK: - Configurations
//
   
    //
    
    private func configureVC() {
        view.backgroundColor = .systemBackground
    }
    
    
    private func configureElements() {
        moveToABButton.titleLabel?.adjustsFontSizeToFitWidth = true
        titleNoteLabel.adjustsFontSizeToFitWidth = true
    }
    
    private func configureTaskBodyTextView() {
        taskBodyTextView.isEditable = false
    }
    
    
    // MARK: - Layout configurations

    private func layoutUI() {
        view.addSubview(titleNoteLabel)
        view.addSubview(taskBodyTextView)
        view.addSubview(editButton)
        view.addSubview(moveToABButton)
        view.addSubview(doneDeleteButton)
        
        let padding: CGFloat = 30
        
        let titleTopConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 10 : -40
        let taskBodyTopConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 10 : 30
        let buttonsBottomConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 10 : 30
        let buttonsInnerLeadingTrailingConstraintsConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 5 : 10
        let doneDeleteButtonBottomConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 10 : 20
        
        let buttonsHeight: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 44 : 50

        
        NSLayoutConstraint.activate([
            titleNoteLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: titleTopConstraintConstant),
            titleNoteLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            titleNoteLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            titleNoteLabel.heightAnchor.constraint(equalToConstant: 40),
            
            taskBodyTextView.topAnchor.constraint(equalTo: titleNoteLabel.bottomAnchor, constant: taskBodyTopConstraintConstant),
            taskBodyTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            taskBodyTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            taskBodyTextView.bottomAnchor.constraint(equalTo: doneDeleteButton.topAnchor, constant: -20),
            
            editButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -buttonsBottomConstraintConstant),
            editButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            editButton.trailingAnchor.constraint(equalTo: doneDeleteButton.centerXAnchor, constant: -buttonsInnerLeadingTrailingConstraintsConstant),
            editButton.heightAnchor.constraint(equalToConstant: buttonsHeight),
            
            moveToABButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            moveToABButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -buttonsBottomConstraintConstant),
            moveToABButton.leadingAnchor.constraint(equalTo: doneDeleteButton.centerXAnchor, constant: buttonsInnerLeadingTrailingConstraintsConstant),
            moveToABButton.heightAnchor.constraint(equalToConstant: buttonsHeight),
            
            doneDeleteButton.bottomAnchor.constraint(equalTo: moveToABButton.topAnchor, constant: -doneDeleteButtonBottomConstraintConstant),
            doneDeleteButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            doneDeleteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            doneDeleteButton.heightAnchor.constraint(equalToConstant: buttonsHeight),
        ])
    }
}
