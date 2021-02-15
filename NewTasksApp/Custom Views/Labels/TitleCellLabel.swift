//
//  TitleCellLabel.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

final class TitleCellLabel: UILabel {

    // MARK: - Overrides

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - Configuration
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        
        adjustsFontSizeToFitWidth   = false
        font                        = UIFont.systemFont(ofSize: 25, weight: .semibold)
        numberOfLines               = 2
        
        textAlignment               = .left
        lineBreakMode               = .byTruncatingTail
    }
}
