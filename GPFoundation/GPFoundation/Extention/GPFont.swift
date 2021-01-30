//
//  GPFont.swift
//  GPFoundation
//
//  Created by jhd on 2020/4/28.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

// MARK: - 项目自适应字体  根据语言切换
public extension UIFont {
    /// 自适应 Regular 字体
    static func AdaptiveRegularFont(size: CGFloat) -> UIFont? {
        return UIFont.SFProTextRegular(size: size)
    }
    
    /// 自适应 Bold 字体
    static func AdaptiveSemiBoldFont(size: CGFloat) -> UIFont? {
        return UIFont.PingFangTCSemibold(size: size)
    }
    
    /// 自适应 Bold 字体
    static func AdaptiveBoldFont(size: CGFloat) -> UIFont? {
        return UIFont.PingFangTCSemibold(size: size)
    }
}


// MARK: - PingFang SC

public extension UIFont {
    static func PingFangSCMedium(size: CGFloat) -> UIFont? {
        return  UIFont(name: "PingFangSC-Medium", size: size)
    }
    
    static func PingFangSCSemibold(size: CGFloat) -> UIFont? {
        return  UIFont(name: "PingFangSC-Semibold", size: size)
    }
    
    static func PingFangSCLight(size: CGFloat) -> UIFont? {
        return  UIFont(name: "PingFangSC-Light", size: size)
    }
    
    static func PingFangSCUltralight(size: CGFloat) -> UIFont? {
        return  UIFont(name: "PingFangSC-Ultralight", size: size)
    }
    
    static func PingFangSCRegular(size: CGFloat) -> UIFont? {
        return  UIFont(name: "PingFangSC-Regular", size: size)
    }
    
    static func PingFangSCThin(size: CGFloat) -> UIFont? {
        return  UIFont(name: "PingFangSC-Thin", size: size)
    }
}

// MARK: - PingFang TC

public extension UIFont {
    static func PingFangTCMedium(size: CGFloat) -> UIFont? {
        return  UIFont(name: "PingFangTC-Medium", size: size)
    }
    
    static func PingFangTCSemibold(size: CGFloat) -> UIFont? {
        return  UIFont(name: "PingFangTC-Semibold", size: size)
    }
    
    static func PingFangTCLight(size: CGFloat) -> UIFont? {
        return  UIFont(name: "PingFangTC-Light", size: size)
    }
    
    static func PingFangTCUltralight(size: CGFloat) -> UIFont? {
        return  UIFont(name: "PingFangTC-Ultralight", size: size)
    }
    
    static func PingFangTCRegular(size: CGFloat) -> UIFont? {
        return  UIFont(name: "PingFangTC-Regular", size: size)
    }
    
    static func PingFangTCThin(size: CGFloat) -> UIFont? {
        return  UIFont(name: "PingFangTC-Thin", size: size)
    }
}

// MARK: - DIN-Alternate-Bold
public extension UIFont {
    static func DINAlternateBold(size: CGFloat) -> UIFont? {
//        registerFont(fontName: "DIN-Alternate-Bold", extension: "ttf", in: bundle)
        return  UIFont(name: "DINCondensed-Bold", size: size)
    }
}


// MARK: - SF-Pro-Text

public extension UIFont {
    static let bundle = Bundle()
    
    static func SFProTextHeavy(size: CGFloat) -> UIFont? {
        registerFont(fontName: "SF-Pro-Text-Heavy", extension: "otf", in: bundle)
        return  UIFont(name: "SFProText-Heavy", size: size)
    }
    
    static func SFProTextLight(size: CGFloat) -> UIFont? {
        registerFont(fontName: "SF-Pro-Text-Light", extension: "otf", in: bundle)
        return  UIFont(name: "SFProText-Light", size: size)
    }
    
    static func SFProTextRegular(size: CGFloat) -> UIFont? {
        registerFont(fontName: "SF-Pro-Text-Regular", extension: "otf", in: bundle)
        return  UIFont(name: "SFProText-Regular", size: size)
    }
    
    static func SFProTextBold(size: CGFloat) -> UIFont? {
        registerFont(fontName: "SF-Pro-Text-Bold", extension: "otf", in: bundle)
        return  UIFont(name: "SFProText-Bold", size: size)
    }
    
    static func SFProTextSemibold(size: CGFloat) -> UIFont? {
        registerFont(fontName: "SF-Pro-Text-Semibold", extension: "otf", in: bundle)
        return  UIFont(name: "SFProText-Semibold", size: size)
    }
    
    static func SFProTextMedium(size: CGFloat) -> UIFont? {
        registerFont(fontName: "SF-Pro-Text-Medium", extension: "otf", in: bundle)
        return  UIFont(name: "SFProText-Medium", size: size)
    }
    
    static func registerFont(fontName: String, extension: String, in bundle: Bundle) {
        guard let fontURL = bundle.url(forResource: fontName, withExtension: `extension`) else { return }
        CTFontManagerRegisterFontsForURL(fontURL as CFURL, CTFontManagerScope.process, nil)
    }
}

