//
//  FollowersListViewController.swift
//  GHFollowers
//
//  Created by Alexandre Madeira on 19/09/22.
//

import UIKit

class FollowersListViewController: UIViewController {
    enum Section {
        case main
    }
    var username: String!
    var followers = [Follower]()
    var collectionView: UICollectionView!
    var dataSource: UICollectionViewDiffableDataSource<Section, Follower>!
    private var page = 1
    private var hasMoreFollowers = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
        configureCollectionView()
        getFollowers(username: username, page: page)
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func configureViewController() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.backgroundColor = .systemBackground
        collectionView.register(FollowerCell.self, forCellWithReuseIdentifier: FollowerCell.reuseID)
    }
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        Task {
            do {
                let followers = try await NetworkManager.shared.getFollowers(for: username, page: page)
                if followers.count < 100 { self.hasMoreFollowers = false }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    DispatchQueue.main.async {
                        self.dismissLoadingView()
                        self.showEmptyStateView(with: "No Followers.", in: self.view)
                    }
                    return
                }
                updateData()
                self.dismissLoadingView()
            } catch {
                self.dismissLoadingView()
                self.presentGFAlertOnMainThread(title: "Error",
                                                message: error.localizedDescription,
                                                buttonTitle: "OK")
            }
        }
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Follower>(collectionView: collectionView, cellProvider: { collectionView, indexPath, follower in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerCell.reuseID,
                                                          for: indexPath) as! FollowerCell
            cell.set(follower: follower)
            return cell
        })
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Follower>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}

extension FollowersListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.height
        if offsetY > contentHeight - height {
            if !hasMoreFollowers { return }
            page += 1
            getFollowers(username: username, page: page)
        }
    }
}
