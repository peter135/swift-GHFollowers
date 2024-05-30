//
//  GFButton.swift
//  GHFollowers
//
//  Created by apple on 2024/5/27.
//

import UIKit

class GFButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(codeer:) has not been implemented")
    }
    
    convenience init(backgroundColor:UIColor, title:String){
        self.init(frame: .zero)
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
        configure()
    }
    
    private func configure(){
        layer.cornerRadius = 10
        titleLabel?.textColor = .white
        titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func set(backgroundColor:UIColor, title:String) {
        self.backgroundColor = backgroundColor
        setTitle(title, for: .normal)
    }
    
}
