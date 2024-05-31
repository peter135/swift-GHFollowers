//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by apple on 2024/5/28.
//

import UIKit

class GFAvatarImageView: UIImageView {
    
    let cache = NetworkManager.shared.cache
    let placeholderImage = Images.placeholder

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        layer.cornerRadius = 16
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints  = false
    }

}
