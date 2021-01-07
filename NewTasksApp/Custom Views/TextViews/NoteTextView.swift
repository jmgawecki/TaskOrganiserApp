//
//  NoteTextView.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 27/12/2020.
//

import UIKit

class NoteTextView: UITextView {

    
    //MARK: - Overrides
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - @ Objectives
    
    @objc private func doneButtonTapped() {
        resignFirstResponder()
    }
    
    
    //MARK: - Configurations
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints   = false
        font                                        = UIFont.systemFont(ofSize: 20)
    }
    
    func configureKeyboardToolbar(in textView: UITextView) {
        guard isEditable == true else { return }
        
        let bar             = UIToolbar()
        let flexibleSpace   = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done            = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        bar.items           = [flexibleSpace,done]
        bar.sizeToFit()
        textView.inputAccessoryView = bar
    }
}
