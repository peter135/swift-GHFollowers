//
//  GFTabbarControllerVC.swift
//  GHFollowers
//
//  Created by apple on 2024/5/30.
//

import UIKit

class GFTabbarControllerVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UITabBar.appearance().tintColor = .systemGreen

        let appearance = UITabBarAppearance()
        appearance.backgroundImage = UIImage()
        appearance.backgroundColor = UIColor.white
        appearance.backgroundEffect = nil
        
        self.tabBar.standardAppearance = appearance
        self.tabBar.scrollEdgeAppearance = appearance
        self.viewControllers = [createSearchNavigationController(), createFavouritesNavigationController()]
    }
    
    func createSearchNavigationController() -> UINavigationController {
        let serachVC = SearchVC()
        serachVC.title = "Search"
        serachVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        
        return UINavigationController(rootViewController: serachVC)
    }
    
    func createFavouritesNavigationController() -> UINavigationController {
        let favouritesListVC = FavouriteListVC()
        favouritesListVC.title = "Favourites"
        favouritesListVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favouritesListVC)
    }
    

}
