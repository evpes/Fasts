//
//  TabBar.swift
//  Fasts
//
//  Created by evpes on 04.01.2022.
//

import UIKit

class TabBar: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupVCs()
        tabBar.clipsToBounds = true
        tabBar.tintColor = K.colors.orangeColor
        // Do any additional setup after loading the view.

    }
        
    func setupVCs() {
        viewControllers = [
        configureViewController(vc: MainViewController(), title: "main", image: UIImage(named: "mainIcon")!),
        configureViewController(vc: UIViewController(), title: "profile", image: UIImage(named: "profileIcon")!),
        configureViewController(vc: UIViewController(), title: "stats", image: UIImage(named: "statsIcon")!),
        configureViewController(vc: UIViewController(), title: "settings", image: UIImage(named: "settingsIcon")!)
        ]
    }
    

    fileprivate func configureViewController(vc: UIViewController,title: String, image: UIImage) -> UIViewController {
        
        vc.tabBarItem.title = title
        vc.tabBarItem.image = image
        return vc
        
    }

}
