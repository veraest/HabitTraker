//
//  TabBarViewController.swift
//  MyHabits
//
//  Created by  User on 23.08.2023.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.tintColor = UIColor(named: "dPurple")
        setupVC()

        
    }
    
    func setupVC() {
        viewControllers = [
            createNavigationController(rootVC: HabitsListViewController(), title: "Привычки", image: UIImage(named: "tabBarLeftIcon")!),
            createNavigationController(rootVC: InfoViewController(), title: "Информация", image: UIImage(systemName: "info.circle.fill")!)
        ]
    }
    
    func createNavigationController(rootVC: UIViewController, title: String, image: UIImage ) -> UINavigationController {
        let navController = UINavigationController(rootViewController: rootVC)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        return navController
    }
}
