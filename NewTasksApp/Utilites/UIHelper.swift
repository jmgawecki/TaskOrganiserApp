//
//  UIHelper.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 26/12/2020.
//

import UIKit

struct UIHelper {
    /// Creates a layout for collection Views from PrioritiesVC and SecondariesVC
    /// - Parameter view: UIView PrioritiesVC or UIView SecondariesVC
    /// - Returns: returns layout
    static func createOneColumnCollectionViewFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth
        
        let itemSized: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 70 : 100
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemSized)
        
        return flowLayout
    }
}
