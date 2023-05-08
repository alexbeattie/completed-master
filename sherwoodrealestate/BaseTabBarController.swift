//
//  BaseTabBarController.swift
//  sherwoodrealestate
//
//  Created by Alex Beattie on 5/11/19.
//  Copyright © 2019 Alex Beattie. All rights reserved.
//


import UIKit

class BaseTabBarControllerViewController: UITabBarController, UITabBarControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let layout = UICollectionViewFlowLayout()
        viewControllers = [
            createNavController(viewController: HomeViewController(), imageName:"house-7"),
            createNavController(viewController: MapOfListings(), imageName: "pin-map-7"),
            createNavController(viewController: SoldListingsHomeController(), imageName: "house-tick-7"),
            createNavController(viewController: MapOfSoldListings(), imageName: "pin-map-tick-7"),
            createNavController(viewController: TeamViewController(collectionViewLayout: layout), imageName: "man-influence")]
    }
    
    fileprivate func createNavController(viewController: UIViewController, imageName: String) -> UIViewController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = UIImage(named: imageName)
        navController.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        return navController
    }
}
