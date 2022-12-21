//
//  NotificationLikeeventTableViewCell.swift
//  Postergram
//
//  Created by Dmytro Ivanenko on 20.12.2022.
//

import SDWebImage
import UIKit

protocol NotificationLikeeventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: UserNotification)
}

class NotificationLikeeventTableViewCell: UITableViewCell {

  static let identifier = "NotificationLikeeventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "@joe liked your photo."
        return label
    }()
    
    private let postButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(named: "test"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(postButton)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: UserNotification) {
        
        self.model = model
        
        switch model.type {
            
        case .like(let post):
            let thumbnail = post.thumbnailImage
            guard !thumbnail.absoluteString.contains("google.com") else {
                return
            }
            
            postButton.sd_setBackgroundImage(with: thumbnail,
                                   for: .normal,
                                   completed: nil)
            
        case .follow:
            break
        }
        
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.profilePhoto, completed: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        postButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        profileImageView.frame = CGRect(x: 3,
                                        y: 3,
                                        width: contentView.heightExt - 6,
                                        height: contentView.heightExt - 6)
        profileImageView.layer.cornerRadius = profileImageView.heightExt / 2
        
        let size = contentView.heightExt - 4
        postButton.frame = CGRect(x: contentView.widthExt - size,
                                  y: 2,
                                  width: size,
                                  height: size)
        
        label.frame = CGRect(x: profileImageView.rightExt,
                             y: 0,
                             width: contentView.widthExt - size - profileImageView.widthExt - 6,
                             height: contentView.heightExt)
        
    }
    
}
