//
//  GFFollowerVC.swift
//  GHFollowers
//
//  Created by apple on 2024/5/29.
//

import UIKit

class GFFollowerItemVC: GFItemInfoVC {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        itemInfoViewOne.set(itemInfoType: .followers , withCount: user.followers)
        itemInfoViewTwo.set(itemInfoType: .following , withCount: user.following)
        actionButton.set(backgroundColor: .systemGreen, title: "github followers")
    }
    

}
