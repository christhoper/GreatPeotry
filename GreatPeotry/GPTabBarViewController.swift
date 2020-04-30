//
//  GPTabBarViewController.swift
//  GreatPeotry
//
//  Created by bailun on 2020/4/28.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit
import CTMediator
import Router
import GPFoundation
import Home


class GPTabBarViewController: UITabBarController {

    private var tabBarItems = [UITabBarItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setApperance()
        self.setupViewControllers()
    }
}


extension GPTabBarViewController {
    private func setApperance() {
        let normalAttributes = [NSAttributedString.Key.foregroundColor: UIColor(hex: 0x9aa0af)]
        let selctedAttributes = [NSAttributedString.Key.foregroundColor: UIColor.globalBlue]
        let backgroundColor = UIColor(red: 250, green: 250, blue: 250)
        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selctedAttributes, for: .selected)
        UITabBar.appearance().isTranslucent = false

        if #available(iOS 13.0, *) {
            let appearance = self.tabBar.standardAppearance.copy()
            appearance.backgroundImage = UIImage()
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear
            appearance.backgroundColor = backgroundColor
            self.tabBar.standardAppearance = appearance
        } else {
            self.tabBar.backgroundImage = UIImage()
            self.tabBar.shadowImage = UIImage()
            self.tabBar.barTintColor = backgroundColor
        }
    }

    private func setupViewControllers() {
        let homeNav = createHomeNavigationController()
        let creationNav = createCreationNavigationController()
        let mineNav = createMineNavigationController()

        let viewControllers: [UIViewController]
        let tabbarItems: [UITabBarItem]

        viewControllers = [homeNav, creationNav, mineNav]
        tabbarItems = [homeNav.tabBarItem, creationNav.tabBarItem, mineNav.tabBarItem]

        self.viewControllers = viewControllers
        self.tabBarItems = tabbarItems

        let imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -10, right: 0)
        for element in tabbarItems {
            element.imageInsets = imageInsets
        }
    }

    private func createHomeNavigationController() -> UINavigationController {
        let homePage = CTMediator.sharedInstance()?.HomePage_GetHomeMainPageViewController(callback: { (_) in
        })
        let homeNav = UINavigationController(rootViewController: homePage!)
        homeNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "def"), selectedImage: UIImage(named: "def"))
        return homeNav
    }

    private func createCreationNavigationController() -> UINavigationController {
        let homePage = CTMediator.sharedInstance()?.HomePage_GetHomeMainPageViewController(callback: { (_) in
        })
        let homeNav = UINavigationController(rootViewController: homePage!)
        homeNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "def"), selectedImage: UIImage(named: "def"))
        return homeNav
    }

    private func createMineNavigationController() -> UINavigationController {
        let homePage = CTMediator.sharedInstance()?.HomePage_GetHomeMainPageViewController(callback: { (_) in
        })
        let homeNav = UINavigationController(rootViewController: homePage!)
        homeNav.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "def"), selectedImage: UIImage(named: "def"))
        return homeNav
    }
}

extension UIImage {
    var original: UIImage {
        return self.withRenderingMode(.alwaysOriginal)
    }
}
