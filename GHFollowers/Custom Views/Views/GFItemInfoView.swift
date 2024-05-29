//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by apple on 2024/5/29.
//

import UIKit

enum ItemInfoType {
    case repos,gists,followers,following
}

class GFItemInfoView: UIView {

    let symbolImageView = UIImageView()
    let titleLabel = GFTitleLabel(textAlignment: .left, fontSzie: 14)
    let countLabel = GFTitleLabel(textAlignment: .center, fontSzie: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubview(symbolImageView)
        addSubview(titleLabel)
        addSubview(countLabel)
        
        symbolImageView.translatesAutoresizingMaskIntoConstraints = false
        symbolImageView.contentMode = .scaleAspectFill
        symbolImageView.tintColor = .label
        
        NSLayoutConstraint.activate([
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor,constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor,constant: 12),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant:18),

        ])
    }
    
    func set(itemInfoType:ItemInfoType, withCount count:Int) {
        switch itemInfoType {
            case .repos:
                 symbolImageView.image = UIImage(systemName: SFSymbols.repos)
                 titleLabel.text = "public repos"
            
            case .gists:
                 symbolImageView.image = UIImage(systemName: SFSymbols.gists)
                 titleLabel.text = "public gists"
           
            case .followers:
                  symbolImageView.image = UIImage(systemName: SFSymbols.followers)
                  titleLabel.text = "followers"
           
            case .following:
                  symbolImageView.image = UIImage(systemName: SFSymbols.following)
                  titleLabel.text = "following"
        }
        
        countLabel.text = String(count)
    }

}
