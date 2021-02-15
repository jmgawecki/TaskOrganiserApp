//
//  UIViewController+Ext.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 15/02/2021.
//

import UIKit

extension UIViewController {
    func tamic(_ views: UIView...) {
        for view in views { view.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    func addSubviews(_ views: UIView...) {
        for view in views { self.view.addSubview(view) }
    }
}
