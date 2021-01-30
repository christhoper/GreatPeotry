//
//  GPNavigationConfigure.swift
//  GPFoundation
//
//  Created by bailun on 2021/1/30.
//  Copyright © 2021 Baillun. All rights reserved.
//

import UIKit

public class GPNavigationConfigure: NSObject, GPNavigationBarConfigProtocol {
    
    public var barTintColor: UIColor
    
    public var tintColor: UIColor
    
    public var shadowColor: UIColor
    
    public var shadowImage: UIImage?
    
    public var backgroundImage: UIImage?
    
    public var titleAttributes: [NSAttributedString.Key : Any]
    
    public var backBtnImage: UIImage?
    
    public var backBtnTitle: String?
    
    public var barStyle: UIBarStyle
    
    public var shadowHidden: Bool
    
    public var statusBarStyle: UIStatusBarStyle
    
    public var layoutMargins: UIEdgeInsets
    
    public var backBtnImageEdgeInsets: UIEdgeInsets
    
    public var backBtnTitleEdgeInsets: UIEdgeInsets
    
    required public override init() {
        barTintColor = .white
        tintColor = .white
        shadowColor = .clear
        titleAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(red: 51, green: 51, blue: 51),
            NSAttributedString.Key.font: UIFont.AdaptiveBoldFont(size: 20)!
        ]
        backBtnImage = R.image.navigation_back()
        barStyle = .default
        shadowHidden = true
        backBtnImageEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        backBtnTitleEdgeInsets = .zero
        statusBarStyle = .default
        layoutMargins = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        shadowImage = UIImage()
        super.init()
    }
}
