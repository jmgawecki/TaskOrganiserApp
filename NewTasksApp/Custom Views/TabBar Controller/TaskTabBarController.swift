//
//  TaskTabBarController.swift
//  NewTasksApp
//
//  Created by Jakub Gawecki on 15/02/2021.
//

import UIKit

final class TaskTabBarController: UITabBarController {
    
    
    
    // MARK: - Overrides and Initialisers
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBarController()
    }
    
    
    // MARK: - TabBar configuration
    
    
    private func configureTabBarController() {
        viewControllers                  = [configurePrioritiesNavigationController(), configureSecondariesNavigationController()]
        UITabBar.appearance().tintColor         = .systemOrange
        UINavigationBar.appearance().tintColor  = .systemOrange
    }
    
    
    private func configurePrioritiesNavigationController() -> UINavigationController {
        let taskA           = PrioritiesVC()
        taskA.title         = "Priorities"
        taskA.tabBarItem    = UITabBarItem(title: "Priorities", image: UIImage(systemName: "tray.fill"), tag: 0)
        return UINavigationController(rootViewController: taskA)
    }
    
    
    private func configureSecondariesNavigationController() -> UINavigationController {
        let taskB           = SecondariesVC()
        taskB.title         = "Secondaries"
        taskB.tabBarItem    = UITabBarItem(title: "Secondaries", image: UIImage(systemName: "tray.2.fill"), tag: 1)
        return UINavigationController(rootViewController: taskB)
    }
}
