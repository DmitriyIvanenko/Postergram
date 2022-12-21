//
//  UserFollowTableViewCell.swift
//  Postergram
//
//  Created by Dmytro Ivanenko on 19.12.2022.
//

import UIKit

protocol UserFollowTableViewCellDelegate: AnyObject {
    func didTapFollowUnfollowButton(model: UserRelationship)
}

enum FollowState {
    case following
    case not_following
}

struct UserRelationship {
    let username: String
    let name: String
    let type: FollowState
}

class UserFollowTableViewCell: UITableViewCell {
    
    static let identifier = "UserFollowTableViewCell"
    
    weak var delegate: UserFollowTableViewCellDelegate?
    
    private var model: UserRelationship?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .secondarySystemBackground
        return imageView
    }()
    
    private let nameLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "Joe"
        label.font = .systemFont(ofSize: 17, weight: .semibold)
        return label
    }()
    
    private let usernameLable: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.text = "@joe"
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .link
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(nameLable)
        contentView.addSubview(usernameLable)
        contentView.addSubview(profileImageView)
        contentView.addSubview(followButton)
        selectionStyle = .none
        
        followButton.addTarget(self, action: #selector(didTapFollowButton), for: .touchUpInside)
    }
    
    @objc private func didTapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnfollowButton(model: model)
    }
    
    public func configure(with model: UserRelationship) {
        self.model = model
        nameLable.text = model.name
        usernameLable.text = model.username
        
        switch model.type {
            
        case.following:
            // swhow unfollow button
            followButton.setTitle("Unfollow", for: .normal)
            followButton.setTitleColor(.label, for: .normal)
            followButton.backgroundColor = .systemBackground
            followButton.layer.borderWidth = 1
            followButton.layer.borderColor = UIColor.label.cgColor

        case.not_following:
            // show follow button
            followButton.setTitle("Follow", for: .normal)
            followButton.setTitleColor(.white, for: .normal)
            followButton.backgroundColor = .link
            followButton.layer.borderWidth = 0
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        nameLable.text = nil
        usernameLable.text = nil
        followButton.setTitle(nil, for: .normal)
        followButton.layer.borderWidth = 0
        followButton.backgroundColor = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelHeight = contentView.heightExt / 2
        let buttonWidth = contentView.widthExt > 500 ? 220 : contentView.widthExt / 3
        
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.heightExt - 6,
                                        height: contentView.heightExt - 6)
        profileImageView.layer.cornerRadius = profileImageView.heightExt / 2.0

        nameLable.frame = CGRect(x: profileImageView.heightExt + 8,
                                 y: 0.0,
                                 width: contentView.widthExt - 8 - profileImageView.widthExt - buttonWidth,
                                 height: labelHeight)
        
        usernameLable.frame = CGRect(x: profileImageView.heightExt + 5,
                                     y: nameLable.bottomExt,
                                 width: contentView.widthExt - 8 - profileImageView.widthExt - buttonWidth,
                                 height: labelHeight)
        
        followButton.frame = CGRect(x: contentView.widthExt - 5 - buttonWidth,
                                    y: (contentView.heightExt - 40) / 2,
                                    width: buttonWidth,
                                    height: 40)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
