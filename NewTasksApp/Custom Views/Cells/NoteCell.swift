//
//  NoteCell.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 25/12/2020.
//

import UIKit

class NoteCell: UICollectionViewCell {
    
    static let reuseId = "NoteCell"
    
    let titleCellLabel  = TitleCellLabel(frame: .zero)
    let iconImageView   = UIImageView(image: UIImage(systemName: "arrowshape.turn.up.right"))
    
    
    // MARK: - Overrides

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
        configureLayoutUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    // MARK: - Configurations

    func set(with message: String) {
        titleCellLabel.text = message
    }
    
    
    private func configureCell() {
        backgroundColor     = .systemBackground
        layer.borderWidth   = 2
        layer.borderColor   = UIColor.systemYellow.cgColor
        layer.cornerRadius  = 15
    }

    
    // MARK: - Layout configurations

    private func configureLayoutUI() {
        addSubview(titleCellLabel)
        addSubview(iconImageView)
        iconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        iconImageView.tintColor = .systemOrange
        
        NSLayoutConstraint.activate([
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0),
            iconImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -17),
            iconImageView.widthAnchor.constraint(equalToConstant: 20),
            iconImageView.heightAnchor.constraint(equalTo: iconImageView.widthAnchor),
            
            titleCellLabel.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            titleCellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleCellLabel.trailingAnchor.constraint(equalTo: iconImageView.leadingAnchor, constant: -15),
            titleCellLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0),
            
            
        ])
    }
}
