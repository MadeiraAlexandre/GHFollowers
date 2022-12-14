//
//  GFAlertViewController.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 19/09/22.
//

import UIKit

class GFAlertViewController: UIViewController {
    private let containerView = UIView()
    private let titleLabel = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let messageLabel = GFBodyLabel(textAlignment: .center)
    private let actionButton = GFButton(backgroundColor: .systemPurple, title: "OK")
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?
    private let padding: CGFloat = 20
    
    init(alertTitle: String? = nil, message: String? = nil, buttonTitle: String? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = alertTitle
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.7)
        configureContainerView()
        configureTitleLabel()
        configureActionButton()
        configureMessageLabel()
    }
    
    private func configureContainerView() {
        view.addSubview(containerView)
        containerView.backgroundColor = .systemBackground
        containerView.layer.cornerRadius = 18
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220)
        ])
    }
    
    private func configureTitleLabel() {
        containerView.addSubview(titleLabel)
        titleLabel.text = alertTitle
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,
                                            constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                               constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: 28)
        ])
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureActionButton() {
        containerView.addSubview(actionButton)
        actionButton.setTitle(buttonTitle, for: .normal)
        actionButton.addTarget(self, action: #selector(dismissVC), for: .touchDown)
        NSLayoutConstraint.activate([
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                                 constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                  constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                   constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
            
        ])
        actionButton.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureMessageLabel() {
        containerView.addSubview(messageLabel)
        messageLabel.text = message
        messageLabel.numberOfLines = 4
        NSLayoutConstraint.activate([
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor,
                                              constant: 8),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor,
                                                 constant: -12),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                  constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                   constant: -padding)
        ])
    }
    
    @objc private func dismissVC() {
        dismiss(animated: true)
    }
}
