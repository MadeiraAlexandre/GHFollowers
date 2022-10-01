//
//  FollowerCell.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 20/09/22.
//

import UIKit

class FollowerCell: UICollectionViewCell {
    static let reuseID = "FollowerCell"
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let usernameLabel = GFTitleLabel(textAlignment: .center, fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(follower: Follower) {
        usernameLabel.text = follower.login
        avatarImageView.loadImage(for: follower.imageUrl)
    }
    
    private func configure() {
        addSubview(avatarImageView)
        addSubview(usernameLabel)
        let padding: CGFloat = 8
        NSLayoutConstraint.activate([
            avatarImageView.topAnchor.constraint(equalTo:topAnchor,constant:padding),
            avatarImageView.leadingAnchor.constraint(equalTo:leadingAnchor,constant:padding),
            avatarImageView.trailingAnchor.constraint(equalTo:trailingAnchor,constant:-padding),
            avatarImageView.heightAnchor.constraint(equalTo:avatarImageView.widthAnchor),
            usernameLabel.topAnchor.constraint(equalTo:avatarImageView.bottomAnchor,constant:12),
            usernameLabel.leadingAnchor.constraint(equalTo:leadingAnchor,constant:padding),
            usernameLabel.trailingAnchor.constraint(equalTo:trailingAnchor,constant:-padding),
            usernameLabel.heightAnchor.constraint(equalToConstant:20)
        ])
    }
}
