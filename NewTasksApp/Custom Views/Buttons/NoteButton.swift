//
//  NoteButton.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

class NoteButton: UIButton {
    
    
    // MARK: - Overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Initialiser
    
    convenience init(backgroundColor: UIColor, fontSize: CGFloat, with message: String) {
        self.init(frame: .zero)
        self.backgroundColor    = backgroundColor
        titleLabel?.font        = UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        setTitle(message, for: .normal)
    }
    
    
    //MARK: - Configuration
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        layer.cornerRadius      = 15
        titleLabel?.textColor   = .white
    }
}
