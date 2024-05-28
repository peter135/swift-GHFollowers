//
//  FavouriteListVC.swift
//  GHFollowers
//
//  Created by apple on 2024/5/27.
//

import UIKit

class FavouriteListVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemYellow

//        setNavbar()
    }
    
    func setNavbar() {
        let textAtt = [NSAttributedString.Key.foregroundColor:UIColor.black,
                       NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Light", size: 19)]
        
        if #available(iOS 15.0, *) {
            let navBarApp = UINavigationBarAppearance()
            navBarApp.backgroundColor = .white
            navBarApp.shadowColor = .white
            navBarApp.titleTextAttributes = textAtt as [NSAttributedString.Key : Any]
            self.navigationController?.navigationBar.scrollEdgeAppearance = navBarApp
            self.navigationController?.navigationBar.standardAppearance = navBarApp
            
        }else{
            self.navigationController?.navigationBar.barTintColor = .white
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.titleTextAttributes = textAtt as [NSAttributedString.Key : Any]
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
        
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.tintColor = .black
    }
    

}
