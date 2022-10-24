//
//  UserInfoViewController.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 23/10/22.
//

import UIKit

class UserInfoViewController: UIViewController {
    var username: String!
    private let headerView = UIView()
    private let itemViewOne = UIView()
    private let itemViewTwo = UIView()
    private var itemsViews = [UIView]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        layoutUI()
        getUser()
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
    }
    
    private func getUser() {
        Task {
            do {
                let user = try await NetworkManager.shared.getUser(for: username)
                DispatchQueue.main.async {
                    self.add(childVC: GFUserInfoHeaderViewController(user: user), to: self.headerView)
                }
            } catch {
                self.presentGFAlertOnMainThread(title: "Something went wrong",
                                                message: error.localizedDescription,
                                                buttonTitle: "OK")
            }
        }
    }
    
    private func layoutUI() {
        itemsViews = [headerView, itemViewOne, itemViewTwo]
        let padding: CGFloat = 20
        for item in itemsViews {
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                item.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                              constant: padding),
                item.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                               constant: -padding)
            ])
        }
        
        itemViewOne.backgroundColor = .systemMint
        itemViewTwo.backgroundColor = .systemCyan
        
        let itemWeight: CGFloat = 140
        NSLayoutConstraint.activate([
            // headerView constraints
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            // itemViewOne constraints
            itemViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor,
                                            constant: padding),
            itemViewOne.heightAnchor.constraint(equalToConstant: itemWeight),
            
            // itemViewTwo constraints
            itemViewTwo.topAnchor.constraint(equalTo: itemViewOne.bottomAnchor,
                                             constant: padding),
            itemViewTwo.heightAnchor.constraint(equalToConstant: itemWeight)
        ])
    }
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
