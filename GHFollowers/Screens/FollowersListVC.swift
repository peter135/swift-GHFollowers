//
//  FollowersListVC.swift
//  GHFollowers
//
//  Created by apple on 2024/5/27.
//

import UIKit

class FollowersListVC: UIViewController {

    var userName:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        
        NetworkManager.shared.getFollowers(for: userName, page: 1) { result in
            
            switch result{
                case .success(let followers):
                    print(followers)

                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "bad stuff happened", message: error.rawValue, buttonTitle: "OK")
            }
            
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

}
