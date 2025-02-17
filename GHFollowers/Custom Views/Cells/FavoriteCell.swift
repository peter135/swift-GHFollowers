//
//  FavoriteCell.swift
//  GHFollowers
//
//  Created by apple on 2024/5/30.
//

import UIKit

class FavoriteCell: UITableViewCell {

    static let resueID = "favoriteCell"
    var avatarImageView = GFAvatarImageView(frame:.zero)
    var usernameLabel   = GFTitleLabel(textAlignment: .left, fontSzie: 26)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite:Follower){
        usernameLabel.text = favorite.login
        NetworkManager.shared.downloadImage(from: favorite.avatarUrl) { [weak self] image in
            guard let self = self else {return}
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        
//        avatarImageView.translatesAutoresizingMaskIntoConstraints  = false
//        usernameLabel.translatesAutoresizingMaskIntoConstraints  = false

        accessoryType       = .disclosureIndicator
        let padding:CGFloat = 20
        
        NSLayoutConstraint.activate([
            avatarImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: padding),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),

            usernameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor,constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -padding),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40),
            
        ])
        
    }
    
}
