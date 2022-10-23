//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 23/10/22.
//

import UIKit

class UserInfoViewController: UIViewController {
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
