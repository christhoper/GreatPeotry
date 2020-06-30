//
//  UserInfoView.swift
//  Mine
//
//  Created by bailun on 2020/6/23.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

class UserInfoView: UIView {
    
    private let avatarImageHeight: CGFloat = 80.0
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = avatarImageHeight / 2
        imageView.backgroundColor = .green
        imageView.clipsToBounds = true
        imageView.kf.setImage(with: URL(string: "https://img.wbp5.com/upload/images/fazzaco/2020/05/20/101045944.webp"))
        return imageView
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Hendy"
        label.defaultConfigure()
        return label
    }()
    
    lazy var followNumberLabel: UILabel = {
        let label = UILabel()
        label.text = "关注: 9999w"
        label.defaultConfigure()
        return label
    }()
    
    lazy var articleView: ItemView = {
        let view = ItemView()
        view.titleLabel.text = "我的文章"
        view.contentLabel.text = "99"
        return view
    }()
    
    
    lazy var invitationView: ItemView = {
        let view = ItemView()
        view.titleLabel.text = "我的帖子"
        view.contentLabel.text = "99"
        return view
    }()
    
    
    lazy var favouriesView: ItemView = {
        let view = ItemView()
        view.titleLabel.text = "赞和收藏"
        view.contentLabel.text = "99"
        return view
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupSubviewsContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(avatarImageView)
        addSubview(followNumberLabel)
        addSubview(userNameLabel)
        addSubview(articleView)
        addSubview(invitationView)
        addSubview(favouriesView)
    }
    
    private func setupSubviewsContraints() {
        let offsetX = 20.0
        
        avatarImageView.snp.makeConstraints { (make) in
            make.left.top.equalToSuperview().offset(offsetX)
            make.size.equalTo(CGSize(width: avatarImageHeight, height: avatarImageHeight))
        }
        
        userNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView)
            make.left.equalTo(avatarImageView.snp.right).offset(5)
            make.right.equalToSuperview().offset(-5).priority(999)
            make.height.equalTo(40)
        }
        
        followNumberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(userNameLabel.snp.bottom)
            make.left.right.height.equalTo(userNameLabel)
        }
        
        let multiple = 1.0 / 3.0
        
        articleView.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(30)
            make.left.bottom.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(multiple)
        }
        
        invitationView.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(articleView)
            make.left.equalTo(articleView.snp.right)
        }
        
        favouriesView.snp.makeConstraints { (make) in
            make.top.bottom.width.equalTo(articleView)
            make.left.equalTo(invitationView.snp.right)
        }
    }
}


class ItemView: UIView {
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray153
        label.font = UIFont.AdaptiveBoldFont(size: 14)
        label.textAlignment = .center
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textColor = .blueTextColor
        label.font = UIFont.DINAlternateBold(size: 30)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createSubviews() {
        addSubview(titleLabel)
        addSubview(contentLabel)
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(17)
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-15)
        }
    }
    
}

