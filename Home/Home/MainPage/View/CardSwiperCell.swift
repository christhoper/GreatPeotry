//
//  CardSwiperCell.swift
//  Home
//
//  Created by bailun on 2020/5/6.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit
import VerticalCardSwiper

class CardSwiperCell: CardCell {
    
    static let identifier = "CardSwiperCell"
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()

    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.addSubview(contentLabel)
        contentLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
}

extension CardSwiperCell {
    
    func setRandomBackgroundColor() {
        let randomRed: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomGreen: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        let randomBlue: CGFloat = CGFloat(arc4random()) / CGFloat(UInt32.max)
        self.backgroundColor = UIColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    }
}
