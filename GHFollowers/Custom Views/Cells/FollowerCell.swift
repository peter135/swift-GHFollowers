//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by apple on 2024/5/28.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let usernameLabel = GFTitleLabel(textAlignment: .center, fontSzie: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower:Follower){
        usernameLabel.text = follower.login
        avatarImageView.downloadImage(from: follower.avatarUrl)
    }
    
    private func configure(){
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
        let padding:CGFloat = 8
        
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo: self.topAnchor,constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor,constant: 12),
            usernameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
            
        ])
        
    }
    
    
    
}
