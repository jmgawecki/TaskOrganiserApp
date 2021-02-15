//
//  BodyNoteLabel.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

final class BodyNoteLabel: UILabel {
    
    // MARK: - Overrides

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Initialiser
    
    convenience init(with title: String) {
        self.init(frame: .zero)
        text = title
    }
    
    
    // MARK: - Configuration
    
    private func configure() {
        textColor                   = .label
        font                        = UIFont.preferredFont(forTextStyle: .body)
        
        lineBreakMode               = .byWordWrapping
        numberOfLines               = .max
        
        translatesAutoresizingMaskIntoConstraints = false
    }
}
