//
//  GFAvatarImageView.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 20/09/22.
//

import UIKit

class GFAvatarImageView: UIImageView {
    private let cache = NetworkManager.shared.cache
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
    
    func loadImage(for value: String) {
        let cacheKey = NSString(string: value)
        if let image = cache.object(forKey: cacheKey) {
            self.image = image
            return
        }
        guard let url = URL(string: value) else { return }
        Task {
            let image = await NetworkManager.shared.downloadImage(from: url)
            guard let image else { return }
            cache.setObject(image, forKey: cacheKey)
            DispatchQueue.main.async { self.image = image }
        }
    }
}
