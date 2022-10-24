//
//  GFItemInfoView.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 24/10/22.
//

import UIKit

class GFItemInfoView: UIView {
    private let symbolImageView = UIImageView()
    private let titleLabel = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private let countLabel = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
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
            // symbolImageView constraints
            symbolImageView.topAnchor.constraint(equalTo: self.topAnchor),
            symbolImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            symbolImageView.widthAnchor.constraint(equalToConstant: 20),
            symbolImageView.heightAnchor.constraint(equalToConstant: 20),
            // titleLabel constraints
            titleLabel.centerYAnchor.constraint(equalTo: symbolImageView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolImageView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 18),
            // countLabel constraints
            countLabel.topAnchor.constraint(equalTo: symbolImageView.bottomAnchor, constant: 4),
            countLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            countLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            countLabel.heightAnchor.constraint(equalToConstant: 18)
        ])
    }
    
    func set(for type: ItemInfoType, count: Int) {
        symbolImageView.image = UIImage(systemName: type.toSFSymbol)
        titleLabel.text = type.title
        countLabel.text = "\(count)"
    }
}

enum ItemInfoType {
    case repos, gists, followers, following
    var title: String {
        switch self {
        case .repos:
            return "folder"
        case .gists:
            return "text.alignleft"
        case .followers:
            return "heart"
        case .following:
            return "person.2"
        }
    }
    var toSFSymbol: String {
        switch self {
        case .repos:
            return "Repos"
        case .gists:
            return "Gists"
        case .followers:
            return "Followers"
        case .following:
            return "Following"
        }
    }
}
