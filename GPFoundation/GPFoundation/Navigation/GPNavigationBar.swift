//
//  GPNavigationBar.swift
//  GPFoundation
//
//  Created by bailun on 2021/1/30.
//  Copyright © 2021 Baillun. All rights reserved.
//

import UIKit

var kGPNavigationBarDefaultConfigClassKey: String?

/// 导航栏配置协议
 @objc public protocol GPNavigationBarConfigProtocol {
    
    var barTintColor: UIColor { get set }
    var tintColor: UIColor { get set }
    var shadowColor: UIColor {get set}
    var shadowImage: UIImage?  { get set }
    var backgroundImage: UIImage? { get set }
    var titleAttributes: [NSAttributedString.Key: Any] { get set }
    var backBtnImage: UIImage? { get set }
    var backBtnTitle: String? { get set }
    var barStyle: UIBarStyle { get set }
    var shadowHidden: Bool { get set }
    var statusBarStyle: UIStatusBarStyle { get set }
    var layoutMargins: UIEdgeInsets { get set }
    
    init()
}


public class GPNavigationBar: UINavigationBar {
    
    lazy var config: GPNavigationBarConfigProtocol = {
        guard let configClass = UINavigationBar.appearance().gp_getDefaultBarDefaultConfigClass()  else {
            fatalError("请在application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?)注册配置类")
        }
        return configClass.init()
    }()
    
    let shadowViewHeight: CGFloat = 0.5
    
    lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentScaleFactor = 1.0
        imageView.contentMode = .scaleToFill
        imageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return imageView
    }()
    
    
    lazy var shadowImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentScaleFactor = 1
        return imageView
    }()
    
    lazy var effectView: UIVisualEffectView = {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        view.isUserInteractionEnabled = false
        view.autoresizingMask = [.flexibleWidth ,.flexibleHeight]
        return view
    }()
    
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        super.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        super.setBackgroundImage(UIImage(), for: .default)
        self.shadowImage = UIImage()
        setupSubviews()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        effectView.frame = effectView.superview?.bounds ?? .zero
        backgroundImageView.frame = backgroundImageView.superview?.bounds ?? .zero
        if let view = shadowImageView.superview {
            shadowImageView.frame = CGRect(x: 0, y: view.bounds.height, width: view.frame.width, height: shadowViewHeight)
        }
        if #available(iOS 13, *) {
            if let barContentView = self.getNavigationBarContentView() {
                let margins = barContentView.layoutMargins;
                let contentViewOriginX = -margins.left + self.config.layoutMargins.left
                let contentViewOriginY = -margins.top
                let contentVeiwWidth = margins.left + margins.right + barContentView.frame.size.width - self.config.layoutMargins.right - self.config.layoutMargins.left
                let contentViewHeight =  margins.top + margins.bottom + barContentView.frame.size.height
                barContentView.frame = CGRect(x: contentViewOriginX, y: contentViewOriginY, width: contentVeiwWidth, height: contentViewHeight)
            }
            
        } else if #available(iOS 11.0, *) {
            if let barContentView = self.getNavigationBarContentView() {
                self.layoutMargins = .zero
                barContentView.layoutMargins = self.config.layoutMargins
            }
        }
    }
    
    public override func addSubview(_ view: UIView) {
        super.addSubview(view)
        let targetClsName = "UINavigationItemButtonView"
        let viewName = view.classForCoder.description().replacingOccurrences(of: "_", with: "")
        if targetClsName == viewName {
            view.isHidden = true
        }
    }
    
    public override var barTintColor: UIColor? {
        didSet {
            effectView.subviews.last?.backgroundColor = barTintColor
            updateEffectView()
        }
    }
    
    public override func setBackgroundImage(_ backgroundImage: UIImage?, for barMetrics: UIBarMetrics) {
        backgroundImageView.image = backgroundImage
        updateEffectView()
    }
    
    public override var shadowImage: UIImage? {
        didSet {
            shadowImageView.image = shadowImage
            if nil != shadowImage {
                shadowImageView.backgroundColor = nil
            } else {
                shadowImageView.backgroundColor = self.config.shadowColor
            }
        }
    }
    
    public override  func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if (!self.isUserInteractionEnabled || self.isHidden || self.alpha < 0.01) {
            return nil
        }
        
        let view = super.hitTest(point, with: event)
        if let _view = view {
            for subView in _view.subviews {
                let subViewName = subView.classForCoder.description().replacingOccurrences(of: "_", with: "")
                let targetNames = ["UINavigationItemButtonView"]
                let coveredPoint = self.convert(point, to: subView)
                if targetNames.contains(subViewName) {
                    if subView.bounds.contains(coveredPoint) {
                        return view
                    }
                }
            }
        }
        
        let selfName = NSStringFromClass(GPNavigationBar.self)
        let targetNames = ["UIButtonBarStackView", "UINavigationBarContentView", selfName]
        if let viewName = view?.classForCoder.description().replacingOccurrences(of: "_", with: ""), targetNames.contains(viewName) {
            if(nil != self.backgroundImageView.image) {
                if self.backgroundImageView.alpha < 0.01 {
                    return nil
                }
            } else if self.effectView.alpha < 0.01 {
                return nil
            }
        }
        
        if let bounds = view?.bounds, bounds == .zero {
            return nil
        }
        
        return view
    }
}

// MARK: - Assistant
extension GPNavigationBar {
    
    func setupSubviews() {
        self.shadowImageView.backgroundColor = self.config.shadowColor
        self.shadowImageView.isHidden = self.config.shadowHidden
        if let contentView = subviews.first {
            contentView.insertSubview(effectView, at: 0)
            contentView.insertSubview(backgroundImageView, aboveSubview: effectView)
            contentView.insertSubview(shadowImageView, aboveSubview: self.backgroundImageView)
        }
    }
    
    func updateEffectView() {
        UIView.setAnimationsEnabled(false)
        if nil == effectView.superview {
            subviews.first?.insertSubview(effectView, at: 0)
            effectView.frame = effectView.superview?.bounds ?? .zero
        }
        
        if nil == backgroundImageView.superview {
            subviews.first?.insertSubview(backgroundImageView, aboveSubview: effectView)
            backgroundImageView.frame = backgroundImageView.superview?.bounds ?? .zero
        }
        
        if (nil == shadowImageView.superview) {
            subviews.first?.insertSubview(shadowImageView, aboveSubview: backgroundImageView)
            if let view = shadowImageView.superview {
                shadowImageView.frame = CGRect(x: 0, y: view.frame.height - shadowViewHeight , width: view.frame.width, height: shadowViewHeight)
            }
        }
        UIView.setAnimationsEnabled(true)
    }
    
    private func getNavigationBarContentView() -> UIView? {
        let contentViewName = "UINavigationBarContentView"
        for subview in self.subviews {
            let subviewName = subview.classForCoder.description().replacingOccurrences(of: "_", with: "")
            if contentViewName == subviewName {
                return subview
            }
        }
        return nil
    }
}

extension UINavigationBar {
    
    public func gp_registerBarDefaultConfigClass(_ configClass: GPNavigationBarConfigProtocol.Type) {
        objc_setAssociatedObject(self, &kGPNavigationBarDefaultConfigClassKey, configClass, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    public func gp_getDefaultBarDefaultConfigClass() -> GPNavigationBarConfigProtocol.Type? {
        return objc_getAssociatedObject(self, &kGPNavigationBarDefaultConfigClassKey) as? GPNavigationBarConfigProtocol.Type
    }
}
