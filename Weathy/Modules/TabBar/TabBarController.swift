//
//  TabBarController.swift
//  Weathy
//
//  Created by Семен Семенов on 21.10.2020.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupViewControllers()
    }

    private func setupLayout() {
        tabBar.barTintColor = R.color.clearWhite()
        tabBar.isTranslucent = true
        tabBar.tintColor = R.color.blue()
        tabBar.unselectedItemTintColor = R.color.gray()
        tabBar.layer.shadowOffset = CGSize(width: 0, height: -4)
        tabBar.layer.shadowRadius = 12
        tabBar.layer.shadowOpacity = 1
        tabBar.layer.shadowColor = R.color.dark()?.withAlphaComponent(0.05).cgColor
    }

    private func setupViewControllers() {
        let mainViewController = MainBuilder().build()
        let placesViewController = UIViewController()
        placesViewController.view.backgroundColor = R.color.clearWhite()

        mainViewController.tabBarItem = UITabBarItem(title: R.string.localizable.mainTitle(), image: R.image.tabMain(), tag: 0)
        placesViewController.tabBarItem = UITabBarItem(title: R.string.localizable.placesTitle(), image: R.image.tabPlaces(), tag: 1)
        
        viewControllers = [mainViewController, placesViewController]
    }
}
