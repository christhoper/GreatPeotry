//
//  GPPlaceholderNavigationBar.swift
//  GPFoundation
//
//  Created by bailun on 2021/1/30.
//  Copyright © 2021 Baillun. All rights reserved.
//

import UIKit

class GPPlaceholderNavigationBar: UIView {
    
    let shadowViewHeight: CGFloat = 0.5
    
    var effectViewBackgroundColor: UIColor? {
        didSet {
            effectView.backgroundColor = effectViewBackgroundColor
            if let lastView = effectView.subviews.last {
                lastView.backgroundColor = effectViewBackgroundColor
            }
        }
    }
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    lazy var effectView: UIVisualEffectView = {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        return effectView
    }()
    
    lazy var shadowView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSubviews()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = self.bounds
        effectView.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.bounds.height - shadowViewHeight)
        shadowView.frame = CGRect(x: 0, y: self.effectView.frame.maxY, width: self.bounds.width, height: shadowViewHeight)
    }
}

extension GPPlaceholderNavigationBar {
    
    func setupSubviews() {
        addSubview(imageView)
        addSubview(effectView)
        addSubview(shadowView)
    }
}
