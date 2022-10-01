//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 20/09/22.
//

import UIKit

class GFAvatarImageView: UIImageView {
    private let placeholderImage = UIImage(named: "GH-Empty")!
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 12
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func loadImage(for url: URL?) {
        Task {
            let image = await NetworkManager.shared.downloadImage(from: url)
            guard let image else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: image)
            }
        }
    }
}
