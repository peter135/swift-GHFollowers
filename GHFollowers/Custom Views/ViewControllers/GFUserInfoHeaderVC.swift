//
//  GFUserInfoHeaderVC.swift
//  GHFollowers
//
//  Created by apple on 2024/5/29.
//

import UIKit

class GFUserInfoHeaderVC: UIViewController {

    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel   = GFTitleLabel(textAlignment: .left, fontSzie: 34)
    let nameLabel       = GFSecondaryTitlelabel(fontSize: 18)
    let locationImageView = UIImageView()
    let locationLabel     = GFSecondaryTitlelabel(fontSize: 18)
    let bioLabel          = GFBodyLabel(textAlignment: .left)
    
    var user:User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        self.user = user
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubview()
        layoutUI()
        configureUIElements()
    }
    
    func configureUIElements(){
        downloadAvatarImage()
        usernameLabel.text          = user.login
        nameLabel.text              = user.name ?? "no name available"
        locationLabel.text          = user.location ?? "no location"
        bioLabel.text               = user.bio ?? "no bio available"
        bioLabel.numberOfLines      = 3
        
        locationImageView.image     = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
    }
    
    func downloadAvatarImage() {
        NetworkManager.shared.downloadImage(from: user.avatarUrl) { [weak self] image in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }
    
    func addSubview() {
        view.addSubview(avatarImageView)
        view.addSubview(usernameLabel)
        view.addSubview(nameLabel)
        view.addSubview(locationImageView)
        view.addSubview(locationLabel)
        view.addSubview(bioLabel)
    }
    
    func layoutUI(){
        let padding:CGFloat          = 20
        let textImagePadding:CGFloat = 12
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 90),
            avatarImageView.heightAnchor.constraint(equalToConstant: 90),

            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.topAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: textImagePadding),
            usernameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 38),

            nameLabel.centerYAnchor.constraint(equalTo: avatarImageView.centerYAnchor,constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: textImagePadding),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),

            locationImageView.bottomAnchor.constraint(equalTo: avatarImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: textImagePadding),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),

            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor,constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            bioLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,constant: textImagePadding),
            bioLabel.leadingAnchor.constraint(equalTo: avatarImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -padding),
            bioLabel.heightAnchor.constraint(equalToConstant: 60),

        ])
    }

}
