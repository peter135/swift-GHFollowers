//
//  GFReopItemVC.swift
//  GHFollowers
//
//  Created by apple on 2024/5/29.
//

import UIKit

class GFReopItemVC: GFItemInfoVC {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .repos , withCount: user.publicRepos)
        itemInfoViewTwo.set(itemInfoType: .gists , withCount: user.publicGists)
        actionButton.set(backgroundColor: .systemPurple, title: "github profile")
    }
    
    

}
