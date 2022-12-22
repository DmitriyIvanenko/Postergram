//
//  IGFeedPoatActionsTableViewCell.swift
//  Postergram
//
//  Created by Dmytro Ivanenko on 06.12.2022.
//

import UIKit

class IGFeedPostActionsTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostActionsTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGreen

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
}
