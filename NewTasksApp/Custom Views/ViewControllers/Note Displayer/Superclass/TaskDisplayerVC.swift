//
//  TaskDisplayerVC.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

class TaskDisplayerVC: UIViewController {
    //MARK: - Declarations
    
    
    let titleNoteLbl        = TitleNoteLabel()
    let taskBodyTxtV        = NoteTextView(frame: .zero)
    let editButton          = NoteButton(backgroundColor: .systemOrange, fontSize: 20, with: "Edit")
    let moveToABBtn         = NoteButton(backgroundColor: .systemTeal, fontSize: 20, with: "")
    let doneDeleteBtn       = NoteButton(backgroundColor: .systemGreen, fontSize: 20, with: "Mark done and delete!")

    
    // MARK: - Overrides

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        configureElements()
        layoutUI()
        configureTaskBodyTextView()
    }
    
    
    // MARK: - Configurations

    
    private func configureVC() { view.backgroundColor = .systemBackground }
    
    
    private func configureElements() {
        moveToABBtn.titleLabel?.adjustsFontSizeToFitWidth    = true
        titleNoteLbl.adjustsFontSizeToFitWidth                = true
    }
    
    
    private func configureTaskBodyTextView() { taskBodyTxtV.isEditable = false }
    
    
    // MARK: - Layout configuration
    

    private func layoutUI() {
        addSubviews(titleNoteLbl, taskBodyTxtV, editButton, moveToABBtn, doneDeleteBtn)
        
        let padding: CGFloat = 30
        
        let titleTopConstraint: CGFloat                     = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 10 : -40
        let taskBodyTopConstraint: CGFloat                  = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 10 : 30
        let buttonsBottomConstraint: CGFloat                = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 10 : 30
        let buttonsInnerLeftRightConstraints: CGFloat       = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 5 : 10
        let doneDeleteButtonBottomConstraint: CGFloat       = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 10 : 20
        
        let buttonsHeight: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 44 : 50

        
        NSLayoutConstraint.activate([
            titleNoteLbl.topAnchor.constraint       (equalTo: view.safeAreaLayoutGuide.topAnchor, constant: titleTopConstraint),
            titleNoteLbl.leadingAnchor.constraint   (equalTo: view.leadingAnchor, constant: padding),
            titleNoteLbl.trailingAnchor.constraint  (equalTo: view.trailingAnchor, constant: -padding),
            titleNoteLbl.heightAnchor.constraint    (equalToConstant: 40),
            
            taskBodyTxtV.topAnchor.constraint       (equalTo: titleNoteLbl.bottomAnchor, constant: taskBodyTopConstraint),
            taskBodyTxtV.leadingAnchor.constraint   (equalTo: view.leadingAnchor, constant: padding),
            taskBodyTxtV.trailingAnchor.constraint  (equalTo: view.trailingAnchor, constant: -padding),
            taskBodyTxtV.bottomAnchor.constraint    (equalTo: doneDeleteBtn.topAnchor, constant: -20),
            
            editButton.bottomAnchor.constraint      (equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -buttonsBottomConstraint),
            editButton.leadingAnchor.constraint     (equalTo: view.leadingAnchor, constant: padding),
            editButton.trailingAnchor.constraint    (equalTo: doneDeleteBtn.centerXAnchor, constant: -buttonsInnerLeftRightConstraints),
            editButton.heightAnchor.constraint      (equalToConstant: buttonsHeight),
            
            moveToABBtn.trailingAnchor.constraint   (equalTo: view.trailingAnchor, constant: -padding),
            moveToABBtn.bottomAnchor.constraint     (equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -buttonsBottomConstraint),
            moveToABBtn.leadingAnchor.constraint    (equalTo: doneDeleteBtn.centerXAnchor, constant: buttonsInnerLeftRightConstraints),
            moveToABBtn.heightAnchor.constraint     (equalToConstant: buttonsHeight),
            
            doneDeleteBtn.bottomAnchor.constraint   (equalTo: moveToABBtn.topAnchor, constant: -doneDeleteButtonBottomConstraint),
            doneDeleteBtn.leadingAnchor.constraint  (equalTo: view.leadingAnchor, constant: padding),
            doneDeleteBtn.trailingAnchor.constraint (equalTo: view.trailingAnchor, constant: -padding),
            doneDeleteBtn.heightAnchor.constraint   (equalToConstant: buttonsHeight),
        ])
    }
}
