//
//  NotificationsViewController.swift
//  Postergram
//
//  Created by Dmytro Ivanenko on 28.11.2022.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.isHidden = false
        tableView.register(NotificationLikeeventTableViewCell.self, forCellReuseIdentifier: NotificationLikeeventTableViewCell.identifier)
        tableView.register(NotificationFollowEventTableViewCell.self, forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        return tableView
    }()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
    
    private lazy var noNotificationsView = NoNotificationsView()
    
    private var models = [UserNotification]()
    
    //MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchNotifications()
        title = .none
        navigationItem.title = "Notifications"
        
        view.addSubview(spinner)
//        spinner.startAnimating()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        
        spinner.frame = CGRect(x: 0,
                               y: 0,
                               width: 100,
                               height: 100)
        spinner.center = view.center
    }
    
    private func fetchNotifications() {
        
        for x in 0...100 {
            
            let user = User(
                username: "joe",
                           bio: "",
                           name: (first: "", last: ""),
                           profilePhoto: URL(string: "https://google.com")!,
                           birthDate: Date(),
                           gender: .male,
                           counts: UserCount(followers: 1, following: 1, posts: 1),
                           joinDate: Date()
            )
            
            
            let post = UserPost(identifier: "",
                                postType: .photo,
                                thumbnailImage: URL(string: "https://google.com")!,
                                postURL: URL(string: "https://google.com")!,
                                caption: nil,
                                likeCount: [],
                                comments: [],
                                createdDate: Date(),
                                taggedUsers: [],
                                owner: user
            )
            
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .not_following),
                                         text: "Hello World",
                                         user: user
            )
            models.append(model)
        }
    }
    
    private func addNoNotificationsView() {
        tableView.isHidden = true
        view.addSubview(tableView)

        noNotificationsView.frame = CGRect(x: 0,
                                           y: 0,
                                           width: view.widthExt / 2,
                                           height: view.heightExt / 4)
        noNotificationsView.center = view.center
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = models[indexPath.row]
       
        switch model.type {
            
        case .like(_):
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeeventTableViewCell.identifier, for: indexPath) as! NotificationLikeeventTableViewCell
            
            cell.configure(with: model)
            cell.delegate = self
            return cell
            
        case .follow:
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            
//            cell.configure(with: model)
            cell.delegate = self
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 52
    }
}


extension NotificationsViewController: NotificationLikeeventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        
        // Open the post
        switch model.type {
            
        case .like(let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
            
        case .follow(_):
            fatalError("Dev issue:  Should never get called")
        }
    }
}

extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
    func didTapFollowUnfollowButton(model: UserNotification) {
        print("Tapped button")
        // Perform database update
    }
}
