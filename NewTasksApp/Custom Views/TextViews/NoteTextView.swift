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
    
    
    //MARK: - Configurations
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false        
        font = UIFont.systemFont(ofSize: 20)
    }
    
    func configureKeyboardToolbar(in textView: UITextView) {
        guard isEditable == true else { return }
        let bar = UIToolbar()
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonTapped))
        bar.items = [done]
        bar.sizeToFit()
        textView.inputAccessoryView = bar
    }
    
    @objc private func doneButtonTapped() {
        resignFirstResponder()
    }
    
}
