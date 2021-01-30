//
//  UIViewController+Navigation.swift
//  GPFoundation
//
//  Created by bailun on 2021/1/30.
//  Copyright © 2021 Baillun. All rights reserved.
//

import UIKit

private var kGPNaviBarStyleConfigKey: String = ""

private var kGPNaviBarStyleKey: String = ""
private var kGPNaviBarBackgroundImageKey: String = ""
private var kGPNaviBarBarTintColorKey: String = ""
private var kGPNaviBarTintColorKey: String = ""
private var kGPNaviBarTitleTextAttributesKey: String = ""

private var kGPNaviBarAlphaKey: String = ""
private var kGPNaviBarHiddenKey: String = ""
private var kGPNaviBarShadowHiddenKey: String = ""

private var kGPNaviBarBackActionHandlerKey: String = ""
private var kGPNaviBarBackBtnTitleKey: String = ""
private var kGPNaviBarCustomBackViewKey: String = ""
private var kGPNaviBarBackBtnImageKey: String = ""

private var kGPStatusBarStyleKey: String = "kGPStatusBarStyleKey"

private var kGPSwipeBackEnabledKey: String = ""
private var kGPClickBackEnabledKey: String = ""

// MARK: - UIViewController + 自定义导航栏
extension UIViewController {
    
    /// 通过基类设置此方法即可
    @objc public var gp_naviBarConfig: GPNavigationBarConfigProtocol {
        guard let configClass = UINavigationBar.appearance().gp_getDefaultBarDefaultConfigClass()  else {
            fatalError("请在application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)注册配置类")
        }
        return configClass.init()
        
    }
    
    @objc public var gp_naviBarStyle: UIBarStyle {
        set {
            objc_setAssociatedObject(self, &kGPNaviBarStyleKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPNaviBarStyleKey) as?  UIBarStyle ?? self.gp_naviBarConfig.barStyle
        }
    }
    
    @objc public var gp_naviBarTintColor: UIColor? {
        set {
            objc_setAssociatedObject(self, &kGPNaviBarBarTintColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPNaviBarBarTintColorKey) as? UIColor ?? self.gp_naviBarConfig.barTintColor
        }
    }
    
    
    @objc public var gp_naviBackgroundImage: UIImage? {
        set {
            objc_setAssociatedObject(self, &kGPNaviBarBackgroundImageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPNaviBarBackgroundImageKey) as? UIImage ?? self.gp_naviBarConfig.backgroundImage
        }
    }
    
    @objc public var gp_naviTintColor: UIColor {
        set {
            objc_setAssociatedObject(self, &kGPNaviBarTintColorKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPNaviBarTintColorKey) as? UIColor ?? self.gp_naviBarConfig.tintColor
        }
    }
    
    @objc public var gp_naviTitleTextAttributes: [NSAttributedString.Key: Any]? {
        set {
            objc_setAssociatedObject(self, &kGPNaviBarTitleTextAttributesKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPNaviBarTitleTextAttributesKey) as? [NSAttributedString.Key: Any] ?? self.gp_naviBarConfig.titleAttributes
        }
    }
    
    @objc public var gp_naviBarAlpha: CGFloat {
        set {
            objc_setAssociatedObject(self, &kGPNaviBarAlphaKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            if gp_naviBarHidden {
                return 0
            }
            return objc_getAssociatedObject(self, &kGPNaviBarAlphaKey) as? CGFloat ?? 1.0
        }
    }
    
    @objc public var gp_naviBarHidden: Bool {
        set {
            if newValue {
                self.navigationItem.titleView = UIView()
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
            } else {
                self.navigationItem.titleView = nil
                self.navigationItem.leftBarButtonItem = nil
            }
            objc_setAssociatedObject(self, &kGPNaviBarHiddenKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPNaviBarHiddenKey) as? Bool ?? false
        }
    }
    
    @objc public var gp_naviShadowHidden: Bool {
        set {
            objc_setAssociatedObject(self, &kGPNaviBarShadowHiddenKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPNaviBarShadowHiddenKey) as? Bool ?? self.gp_naviBarConfig.shadowHidden
        }
    }
    
    @objc public var gp_naviBarImage: UIImage? {
        set {
            objc_setAssociatedObject(self, &kGPNaviBarBackgroundImageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPNaviBarBackgroundImageKey) as? UIImage ?? self.gp_naviBarConfig.backgroundImage
        }
    }
    
    @objc public var gp_naviBackBtnImage: UIImage? {
        set {
            objc_setAssociatedObject(self, &kGPNaviBarBackBtnImageKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return (objc_getAssociatedObject(self, &kGPNaviBarBackBtnImageKey) as? UIImage) ?? self.gp_naviBarConfig.backBtnImage
        }
    }
    
    @objc public var gp_naviBackBtnTitle: String? {
        set {
            objc_setAssociatedObject(self, &kGPNaviBarBackBtnTitleKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPNaviBarBackBtnTitleKey) as? String ?? self.gp_naviBarConfig.backBtnTitle
        }
    }
    
    @objc public var gp_customBackView: UIView? {
        set {
            objc_setAssociatedObject(self, &kGPNaviBarCustomBackViewKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPNaviBarCustomBackViewKey) as? UIView
        }
    }
    
    /// 点击返回
    @objc public var gp_naviBackActionHandler: ((UIButton) -> Void)? {
        set {
            objc_setAssociatedObject(self, &kGPNaviBarBackActionHandlerKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPNaviBarBackActionHandlerKey) as? ((UIButton) -> Void)
        }
    }
    
    /// 是否可以侧滑返回
    @objc public var gp_swipeBackEnbaled: Bool {
        set {
            objc_setAssociatedObject(self, &kGPSwipeBackEnabledKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPSwipeBackEnabledKey) as? Bool ?? true
        }
    }
    
    /// 状态栏的默认样式
    
    @objc public var gp_statusBarStyle: UIStatusBarStyle {
        set {
            objc_setAssociatedObject(self, &kGPStatusBarStyleKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPStatusBarStyleKey) as? UIStatusBarStyle ?? self.gp_naviBarConfig.statusBarStyle
        }
    }
    
    /// 是否可以点击返回按钮返回
    @objc public var gp_clickBackEnabled: Bool {
        set {
            objc_setAssociatedObject(self, &kGPClickBackEnabledKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
        
        get {
            return objc_getAssociatedObject(self, &kGPClickBackEnabledKey) as? Bool ?? true
        }
    }
    
    final var gp_cumputedNaviShadowAlpha: CGFloat {
        return self.gp_naviShadowHidden ? 0 : self.gp_naviBarAlpha
    }
    
    
    final var gp_computedNaviBarImage: UIImage? {
        if let image = self.gp_naviBarImage {
            return image
        }
        return nil == self.gp_naviBarTintColor ? UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default) : nil
        
    }
    
    final var gp_computedNaviBarTintColor: UIColor? {
        if nil != self.gp_naviBarImage {
            return nil
        }
        
        var color = self.gp_naviBarTintColor
        
        let isUseDelfault = nil == color && nil == UINavigationBar.appearance().backgroundImage(for: UIBarMetrics.default)
        if isUseDelfault {
            if nil != UINavigationBar.appearance().barTintColor {
                color = UINavigationBar.appearance().barTintColor
            } else {
                let defualtStyleColor = UIColor(red: 247.0 / 255.0, green: 247.0 / 255.0, blue: 247.0 / 255.0, alpha: 0.8)
                let lightStyleColor = UIColor(red: 28.0 / 255.0, green: 28.0 / 255.0, blue: 28 / 255.0, alpha: 0.729)
                color = UINavigationBar.appearance().barStyle == .default ? defualtStyleColor : lightStyleColor
            }
        }
        return color
    }
}


// MARK: - 外部更新导航栏
extension UIViewController {
    
    /// 更新导航栏样式
    @objc public func gp_setNeedsUpdateNavigationBar() {
        guard let navigationController = self.navigationController as? GPNavigationController else {
            return
        }
        navigationController.updateNavigationBarStyle(for: self)
    }
    
    /// 更新导航栏透明度
    @objc public func gp_setNeedsUpdateNavigationBarAlpha() {
        guard let navigationController = self.navigationController as? GPNavigationController else {
            return
        }
        navigationController.updateNavigationBarAlpha(for: self)
    }
    
    /// 更新导航栏barTintColor 或者 图片
    @objc public func gp_setNeedsUpdateNavigationBarTintColorOrImage() {
        guard let navigationController = self.navigationController as? GPNavigationController else {
            return
        }
        navigationController.updateNavigationBarTintColorOrImage(for: self)
    }
    
    /// 更新导航栏阴影透明度
    @objc public func gp_setNeedsUpdateNavigationBarShadowAlpha() {
        guard let navigationController = self.navigationController as? GPNavigationController else {
            return
        }
        navigationController.updateNavigationBarShadowAlpha(for: self)
    }
}
