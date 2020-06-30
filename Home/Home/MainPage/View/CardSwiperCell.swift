//
//  CardSwiperCell.swift
//  Home
//
//  Created by bailun on 2020/5/6.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit


class CardSwiperCell: CardCell {
    
    static let identifier = "CardSwiperCell"
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.AdaptiveBoldFont(size: 12)
        label.textColor = UIColor.gray51
        return label
    }()
    
    lazy var peotryTitleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()

    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setupSubviews()
        self.setupSubviewsContraints()
    }
}

extension CardSwiperCell {
    private func setupSubviews() {
        self.backgroundColor = UIColor.mainColor
        contentView.addSubview(authorLabel)
        contentView.addSubview(peotryTitleLabel)
        contentView.addSubview(contentLabel)
    }
    
    private func setupSubviewsContraints() {
        authorLabel.snp.makeConstraints { (make) in
            make.top.equalTo(peotryTitleLabel.snp.bottom)
            make.centerX.equalToSuperview().offset(50)
        }
        
        peotryTitleLabel.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
        }
        
        contentLabel.snp.makeConstraints { (make) in
            make.top.equalTo(authorLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
    }
}

extension CardSwiperCell {
    
    func setRandomBackgroundColor() {
//        let randomRed: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
//        let randomGreen: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
//        let randomBlue: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
//        self.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
    
    func setupCell(for entity: MainPageEntity) {
        authorLabel.text = entity.author
        peotryTitleLabel.text = entity.title
        contentLabel.text = entity.content
    }
}
