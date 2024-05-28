//
//  SearchVC.swift
//  GHFollowers
//
//  Created by apple on 2024/5/27.
//

import UIKit
import Foundation

class SearchVC: UIViewController {

    let logoImageView       = UIImageView()
    let userNameTextField   = GFTextfield()
    let callToActionButton  = GFButton(backgroundColor: .green, title: "Get Followers")
    
    var isUserNameEntered:Bool{
        return !userNameTextField.text!.isEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
//        setNavbar()
        configureLogoImageView()
        configureTextField()
        configureCallToActionButton()
        createDismissKeyboardTapGesture()
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
//            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.titleTextAttributes = textAtt as [NSAttributedString.Key : Any]
//            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        }
        
//        self.navigationController?.navigationBar.isTranslucent = false
//        self.navigationController?.navigationBar.tintColor = .black
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)

    }
    
    func createDismissKeyboardTapGesture(){
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowerListVC(){
        
        guard isUserNameEntered else {
            presentGFAlertOnMainThread(title: "empty username", message: "pls enter a username, we need know who you are looking for", buttonTitle: "OK")
            print("no user name")
            return
        }
        
        let followerListVC = FollowersListVC()
        followerListVC.userName = userNameTextField.text
        followerListVC.title = userNameTextField.text
        navigationController?.pushViewController(followerListVC, animated: true)
    }
    
    func configureLogoImageView() {
        view.addSubview(logoImageView)
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        logoImageView.image = UIImage(named: "gh-logo")
        
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200)
        ])
        
    }
    
    func configureTextField(){
        view.addSubview(userNameTextField)
        userNameTextField.delegate = self
        
        NSLayoutConstraint.activate([
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    func configureCallToActionButton() {
        view.addSubview(callToActionButton)
        callToActionButton.addTarget(self, action: #selector(pushFollowerListVC), for: .touchUpInside)
        
        
        NSLayoutConstraint.activate([
            callToActionButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,constant: -50),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }

}

extension SearchVC:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        return true
    }
    
}
