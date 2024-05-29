//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by apple on 2024/5/29.
//

import UIKit

class UserInfoVC: UIViewController {

    let headView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews:[UIView] = []

    var username:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureViewController()
        layoutUI()
        getUserInfo()
        
    }
    
    func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    func getUserInfo() {
        NetworkManager.shared.getUserInfo(for: username) {[weak self] result in
            guard let self = self else {return}
            
            switch result {
                case .success(let user):
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headView)
                    self.add(childVC: GFReopItemVC(user: user),      to: self.itemViewOne)
                    self.add(childVC: GFFollowerItemVC(user: user),  to: self.itemViewTwo)

                }
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "something wrong", message: error.rawValue, buttonTitle: "OK")
            }
            
        }
    }
    
    func layoutUI(){
        itemViews = [headView,itemViewOne,itemViewTwo]
        
        for itemView in itemViews {
            view.addSubview(itemView)
            itemView.translatesAutoresizingMaskIntoConstraints = false
        }

        itemViewOne.backgroundColor = .systemBackground
        itemViewTwo.backgroundColor = .systemBackground

        let padding:CGFloat = 20
        let itemHeight:CGFloat = 140
        
        NSLayoutConstraint.activate([
            headView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headView.heightAnchor.constraint(equalToConstant: 180),
            
            itemViewOne.topAnchor.constraint(equalTo: headView.bottomAnchor,constant: padding),
            itemViewOne.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            itemViewOne.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemHeight),
            
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor,constant: padding),
            itemViewTwo.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            itemViewTwo.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemHeight),
            
        ])
    }
    
    
    func add(childVC:UIViewController, to containerView:UIView){
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc func dismissVC(){
        dismiss(animated: true)
    }
    
}
