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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done,
                                         target: self,
                                         action: #selector(dismissVC))
        navigationItem.rightBarButtonItem = doneButton
        layoutUI()
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
        view.addSubview(headerView)
        view.addSubview(itemViewOne)
        view.addSubview(itemViewTwo)
//        let views = [headerView, itemViewOne, itemViewTwo]
//        for view in views {
//            view.addSubview(view)
//        }
        //view.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180)
        ])
    }
    
    func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
