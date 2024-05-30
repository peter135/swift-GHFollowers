//
//  UserInfoVC.swift
//  GHFollowers
//
//  Created by apple on 2024/5/29.
//

import UIKit
import SafariServices

protocol UserInfoVCDelegate:AnyObject {
    func didTapGitHubProfile(for user:User)
    func didTapGetFollowers(for user:User)
}

class UserInfoVC: UIViewController {

    let headView = UIView()
    let itemViewOne = UIView()
    let itemViewTwo = UIView()
    var itemViews:[UIView] = []
    var dateLabel = GFBodyLabel()

    var username:String!
    weak var delegate:FollowerListVCDelegate!
    
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
                    self.configureUIElements(with: user)
                }
                case .failure(let error):
                    self.presentGFAlertOnMainThread(title: "something wrong", message: error.rawValue, buttonTitle: "OK")
            }
            
        }
    }
    
    func configureUIElements(with user:User) {
        
        let repoItemVC = GFReopItemVC(user: user)
        repoItemVC.delegate = self
        
        let followerItemVC = GFFollowerItemVC(user: user)
        followerItemVC.delegate = self
        
        self.add(childVC: repoItemVC,      to: self.itemViewOne)
        self.add(childVC: followerItemVC,  to: self.itemViewTwo)
        self.add(childVC: GFUserInfoHeaderVC(user: user), to: self.headView)
        self.dateLabel.text = "github since \(user.createdAt.convertToMonthYearFormat())"
    }
    
    func layoutUI(){
        itemViews = [headView,itemViewOne,itemViewTwo,dateLabel]
        
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
            
            dateLabel.topAnchor.constraint(equalTo: itemViewTwo.bottomAnchor,constant: padding),
            dateLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            dateLabel.heightAnchor.constraint(equalToConstant: 18),
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

extension UserInfoVC: UserInfoVCDelegate {
    
    func didTapGetFollowers(for user:User) {
        
        guard  user.followers != 0 else {
            presentGFAlertOnMainThread(title: "no followers", message: "what a shame", buttonTitle: "ok")
            return
        }
        self.delegate.didRequestForFollowers(for: user.login)
        dismissVC()
    }
    
    func didTapGitHubProfile(for user:User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentGFAlertOnMainThread(title: "invalid url", message: "the url attached to this user is not available", buttonTitle: "ok")
            return
        }
        presentSafariVC(with: url)
        
    }
    
}
