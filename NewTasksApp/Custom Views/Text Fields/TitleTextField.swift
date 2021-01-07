//
//  TitleTextField.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

class TitleTextField: UITextField {

    // MARK: - Overrides
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Configuration
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        layer.cornerRadius  = 10
        textAlignment       = .left
        font                = UIFont.systemFont(ofSize: 30, weight: .bold)
        
        placeholder         = "Add Title.."
        returnKeyType       = .done
        autocorrectionType  = .yes
        
    }
    
}
