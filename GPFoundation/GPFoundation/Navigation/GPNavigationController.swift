//
//  GPNavigationController.swift
//  GPFoundation
//
//  Created by jhd on 2020/7/1.
//  Copyright © 2020 jhd. All rights reserved.
//

import UIKit

// MARK: -
/// 自定义导航控制器
public class GPNavigationController: UINavigationController {
    
    var popingViewController: UIViewController?
    var isTransitional: Bool = false
    
    var gp_navigationBar: GPNavigationBar {
        return self.navigationBar as! GPNavigationBar
    }
    
    // 处理14.0，14.1系统下，pop回到某个controller，tab隐藏掉的问题，14.2系统苹果已修复这个bug
    var canHideBottomForNextPush: Bool {
        let systemVersion: String = UIDevice.current.systemVersion
        if systemVersion.hasPrefix("14.0") || systemVersion.hasPrefix("14.1")  {
            return viewControllers.count == 1
        } else {
            return true
        }
    }
    
    /// 源控制器上的占位导航栏
    var fromPlaceholderBar: GPPlaceholderNavigationBar?
    /// 目标控制器上的占位导航栏
    var toPlaceholderNaviBar: GPPlaceholderNavigationBar?
    
    private var currentVC: UIViewController? {
        return getWindowCurrentViewController()
    }
    
    // MARK: - 状态栏相关
    /// 状态栏样式
    public override var preferredStatusBarStyle: UIStatusBarStyle {
        return currentVC?.gp_statusBarStyle ?? .default
    }
    
    /// 状态栏隐藏动画
    public override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return currentVC?.preferredStatusBarUpdateAnimation ?? .none
    }
    
    public override var childForStatusBarHidden: UIViewController? {
        return self.currentVC
    }
    
    // MARK: - Initilization
    public override init(rootViewController: UIViewController) {
        super.init(navigationBarClass: GPNavigationBar.self, toolbarClass: nil)
        viewControllers = [rootViewController]
    }
    
    public override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
        guard navigationBarClass is GPNavigationBar.Type else {
            fatalError("导航栏必须为BLNavigationBar")
        }
        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: Life Circle
    override public func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        // 全屏侧滑返回
        self.interactivePopGestureRecognizer?.delegate = self
        self.interactivePopGestureRecognizer?.addTarget(self, action: #selector(onPopGesture(sender:)))
        
        //  设置默认样式
        self.gp_navigationBar.isTranslucent = true
        
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        guard let topViewController = self.topViewController else {
            return
        }
        
        topViewController.view.frame = topViewController.view.frame
        if let from = transitionCoordinator?.viewController(forKey: .from), from == popingViewController, !isTransitional {
            updateNavigationBarStyle(for: from)
            return
        }
        updateNavigationBarStyle(for: topViewController)
    }
    
    
    // MARK: - Push & Pop
    public override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        viewController.hidesBottomBarWhenPushed = canHideBottomForNextPush
        super.pushViewController(viewController, animated: animated)
        interactivePopGestureRecognizer?.isEnabled = true
    }
    
    public override func popViewController(animated: Bool) -> UIViewController? {
        popingViewController = topViewController
        if let vc = super.popViewController(animated: animated) {
            gp_navigationBar.barStyle = vc.gp_naviBarStyle
            gp_navigationBar.titleTextAttributes = vc.gp_naviTitleTextAttributes
            return vc
        }
        return nil
    }
    
    public override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        popingViewController = topViewController
        let viewControllers = super.popToViewController(viewController, animated: animated)
        if let vc = topViewController {
            gp_navigationBar.barStyle = vc.gp_naviBarStyle
            gp_navigationBar.titleTextAttributes  = vc.gp_naviTitleTextAttributes
        }
        return viewControllers
    }
    
    public override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        popingViewController = topViewController
        let viewContollers = super.popToRootViewController(animated: animated)
        if let vc = topViewController {
            gp_navigationBar.barStyle = vc.gp_naviBarStyle
            gp_navigationBar.titleTextAttributes = vc.gp_naviTitleTextAttributes
        }
        return viewContollers
    }
}

// MARK: - UI构建
extension GPNavigationController {
    
    func setupBackNavigationBarItem(for viewController: UIViewController) {
        let isAddBackBtn = !viewController.gp_naviBarHidden && nil == viewController.navigationItem.leftBarButtonItem && nil == viewController.navigationItem.leftBarButtonItems && self.viewControllers.count > 1
        if !isAddBackBtn {
            return
        }
        
        if let view = viewController.gp_customBackView {
            // 如果控制器自定义了则使用默认的，则使用
            let barButtonItem = UIBarButtonItem(customView:view)
            barButtonItem.width = view.frame.width
            if #available(iOS 11, *) {
                viewController.navigationItem.leftBarButtonItem = barButtonItem
            } else {
                let speer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
                speer.width = -viewController.gp_naviBarConfig.layoutMargins.left
                viewController.navigationItem.leftBarButtonItems = [speer, barButtonItem]
            }
            return
        }
        viewController.navigationItem.hidesBackButton = true
        var backBtn: UIButton!
        var backBtnTitle: String?
        var backBtnImage: UIImage?
        
        // 获取自定义的图片与文字，优先级config < viewcontroller
        if let title = viewController.gp_naviBackBtnTitle {
            backBtnTitle = title
        }
        if let image = viewController.gp_naviBackBtnImage {
            backBtnImage = image
        }
        
        if nil == backBtn {
            backBtn = UIButton(type: .custom)
            backBtn?.frame = CGRect(x: 0, y: 0, width: 64, height: 44)
            backBtn?.setTitle(backBtnTitle, for: .normal)
            backBtn?.setTitleColor(UIColor.white, for: .normal)
            backBtn?.setTitleColor(self.navigationBar.tintColor, for:.normal)
            backBtn?.setTitleColor(UIColor(white: 1, alpha: 0.85), for: .highlighted)
            backBtn?.setImage(backBtnImage, for: .normal)
            backBtn?.contentHorizontalAlignment = .left
            backBtn?.addTarget(self, action: #selector(onClickBackBtn(sender:)), for: .touchUpInside)
        }
        
        let backBarButtonItem = UIBarButtonItem(customView: backBtn)
        if #available(iOS 11.0, *) {
            viewController.navigationItem.leftBarButtonItem = backBarButtonItem
        } else {
            let speer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
            speer.width = -viewController.gp_naviBarConfig.layoutMargins.left
            viewController.navigationItem.leftBarButtonItems = [speer, backBarButtonItem]
        }
    }
    
    private func getWindowCurrentViewController() -> UIViewController? {
        var current: UIViewController? = UIApplication.shared.delegate?.window??.rootViewController
        while true {
            if let tab = current as? UITabBarController {
                current = tab.selectedViewController
            } else if let nav = current as? UINavigationController {
                current = nav.visibleViewController
            } else if let presented = current?.presentedViewController {
                current = presented
            } else {
                break
            }
        }
        return current
    }
}

// MARK: -  导航栏样式
extension GPNavigationController {
   
    /// 更新指定控制器的导航栏样式
    ///
    /// - Parameter vc: 待更新的控制器
    func updateNavigationBarStyle(for vc: UIViewController) {
        updateNavigationBarAlpha(for: vc)
        updateNavigationBarAttributes(for: vc)
        updateNavigationBarTintColorOrImage(for: vc)
        updateNavigationBarShadowAlpha(for: vc)
    }
    
    /// 更新导航栏的文字属性、样式、主题颜色
    ///
    /// - Parameter vc: 待更新的控制器
    func updateNavigationBarAttributes(for vc: UIViewController) {
        UIView.setAnimationsEnabled(false)
        navigationBar.barStyle = vc.gp_naviBarStyle
        navigationBar.tintColor = vc.gp_naviTintColor
        navigationBar.titleTextAttributes = vc.gp_naviTitleTextAttributes
        UIView.setAnimationsEnabled(true)
    }
    
    /// 更新指定控制器的导航栏透明度
    ///
    /// - Parameter vc: 待更新的控制器
    func updateNavigationBarAlpha(for vc: UIViewController) {
        if nil != vc.gp_computedNaviBarImage {
            self.gp_navigationBar.effectView.alpha = 0
            self.gp_navigationBar.backgroundImageView.alpha = vc.gp_naviBarAlpha
        } else {
            self.gp_navigationBar.effectView.alpha = vc.gp_naviBarAlpha
            self.gp_navigationBar.backgroundImageView.alpha = 0
        }
        self.gp_navigationBar.shadowImageView.alpha = vc.gp_cumputedNaviShadowAlpha
    }
    
    
    /// 更新指定控制器的导航栏背景颜色、背景图片
    ///
    /// - Parameter vc: 待更新的控制器
    func updateNavigationBarTintColorOrImage(for vc: UIViewController) {
        self.gp_navigationBar.barTintColor = vc.gp_computedNaviBarTintColor
        self.gp_navigationBar.backgroundImageView.image = vc.gp_computedNaviBarImage
    }
    
    /// 更新指定控制器的导航栏阴影透明度
    ///
    /// - Parameter vc: 待更新的控制器
    func updateNavigationBarShadowAlpha(for vc: UIViewController) {
        self.gp_navigationBar.shadowImageView.alpha = vc.gp_cumputedNaviShadowAlpha
    }
}

// MARK: - 占位导航栏
extension GPNavigationController {
    
    /// 添加占位导航栏
    ///
    /// - Parameters:
    ///   - fromViewController: 源控制器
    ///   - toViewController: 目标控制器
    func addPaceholderBarTo(from fromViewController: UIViewController, to toViewController: UIViewController) {
        UIView.setAnimationsEnabled(false)
        gp_navigationBar.effectView.alpha = 0
        gp_navigationBar.shadowImageView.alpha = 0
        gp_navigationBar.backgroundImageView.alpha = 0
        addPlaceholderBarToFrom(fromViewController)
        addPlaceholderBarToTarget(toViewController)
        UIView.setAnimationsEnabled(true)
    }
    
    /// 在源控制器上添加占位导航栏
    ///
    /// - Parameter viewController: 源控制器
    func addPlaceholderBarToFrom(_ viewController: UIViewController) {
        if fromPlaceholderBar == nil {
            fromPlaceholderBar = GPPlaceholderNavigationBar()
        }
        fromPlaceholderBar?.imageView.image = viewController.gp_computedNaviBarImage
        fromPlaceholderBar?.imageView.alpha = viewController.gp_naviBarAlpha
        if let color = viewController.gp_computedNaviBarTintColor {
            fromPlaceholderBar?.effectViewBackgroundColor = color
        }
        
        fromPlaceholderBar?.alpha = viewController.gp_naviBarAlpha == 0 || nil != viewController.gp_computedNaviBarImage ? 0.01 : viewController.gp_naviBarAlpha
        if 0 == viewController.gp_naviBarAlpha || nil != gp_computedNaviBarImage {
            fromPlaceholderBar?.effectView.subviews.last?.alpha = 0.01
        }
        
        fromPlaceholderBar?.shadowView.alpha =  viewController.gp_cumputedNaviShadowAlpha
        
        fromPlaceholderBar?.frame = frameForPlaceholderBar(on: viewController)
        viewController.view.addSubview(fromPlaceholderBar!)
        
    }
    
    /// 在目标控制器上添加占位导航栏
    ///
    /// - Parameter viewController: 目标控制器
    func addPlaceholderBarToTarget(_ viewController: UIViewController ) {
        if toPlaceholderNaviBar == nil {
            toPlaceholderNaviBar = GPPlaceholderNavigationBar()
        }
        toPlaceholderNaviBar?.imageView.image = viewController.gp_computedNaviBarImage
        toPlaceholderNaviBar?.imageView.alpha = viewController.gp_naviBarAlpha
        
        if let color = viewController.gp_computedNaviBarTintColor {
            toPlaceholderNaviBar?.effectViewBackgroundColor = color
        }
        
        toPlaceholderNaviBar?.alpha = nil != viewController.gp_computedNaviBarImage ? 0 : viewController.gp_naviBarAlpha
        toPlaceholderNaviBar?.shadowView.alpha = viewController.gp_cumputedNaviShadowAlpha
        
        toPlaceholderNaviBar?.frame = frameForPlaceholderBar(on: viewController)
        viewController.view.addSubview(toPlaceholderNaviBar!)
    }
    
    /// 移除导航栏
    func removePlaceholderBar() {
        fromPlaceholderBar?.removeFromSuperview()
        toPlaceholderNaviBar?.removeFromSuperview()
        fromPlaceholderBar = nil
        toPlaceholderNaviBar = nil
    }
    
    ///  计算占位导航栏的frame
    func frameForPlaceholderBar(on viewController: UIViewController) -> CGRect {
        guard let view = navigationBar.subviews.first else {
            return .zero
        }
        
        var frame = navigationBar.convert(view.frame, to: viewController.view)
        frame.origin.x = viewController.view.frame.origin.x
        if let scrollView = viewController.view as? UIScrollView, 0 == scrollView.contentOffset.y {
            frame.origin.y = isIphoneX() ? -88 : -64
        }
        return frame
    }
}

// MARK: - 重置导航栏子视图
extension GPNavigationController {

    /// 重置导航栏子视图透明度
    ///
    /// - Parameter naviBar: 待重置的导航栏
    func resetSubviews(in naviBar: UINavigationBar) {
        if #available(iOS 11.0, *) {
            return
        }
        naviBar.subviews.forEach { (subview) in
            if subview.alpha < 1.0 {
                UIView.animate(withDuration: 0.25, animations: {
                    subview.alpha = 1.0
                })
            }
        }
    }
    
    /// 重置指定导航栏上的返回按钮
    ///
    /// - Parameter naviBar: 待重置的导航栏
    func resetBtnLabelInNaviBar(_ naviBar: UINavigationBar) {
        guard #available(iOS 12.0, *) else {
            return
        }
        
        let targetClassName = "UINavigationBarContentView"
        for subview in naviBar.subviews {
            let subviewClassName =  subview.classForCoder.description().replacingOccurrences(of: "_", with: "")
            if subviewClassName == targetClassName {
                self.resetBtnLabelInView(subview)
                break
            }
        }
    }
    
    /// 重置指定视图上的 UIButtonLabel
    ///
    /// - Parameter view: 待重置的视图
    func resetBtnLabelInView(_ view: UIView) {
        let targetClassName = "UIButtonLabel"
        let viewClassName = view.classForCoder.description().replacingOccurrences(of: "_", with: "")
        if targetClassName == viewClassName {
            view.alpha = 1.0
            return
        }
        view.subviews.forEach { [weak self] (subview) in
            guard let self = self else {
                return
            }
            self.resetBtnLabelInView(subview)
        }
    }
}

// MARK: - 转场动画
extension GPNavigationController {
    
    func showViewController(_ vc: UIViewController, with coordinator: UIViewControllerTransitionCoordinator) {
        guard let from  = coordinator.viewController(forKey: .from), let to = coordinator.viewController(forKey: .to) else {
            return
        }
        resetBtnLabelInNaviBar(self.gp_navigationBar)
        
        coordinator.animate(alongsideTransition: { [weak self] (context) in
            guard let self = self else {
                return
            }
            
            let isShowPlaceholderBar = self.shouldAddPlaceholderBar(on: vc, from: from, to: to)
            if isShowPlaceholderBar {
                self.showViewControllerAlongsideTransition(vc, from: from, to: to, isInteractive: coordinator.isInteractive)
            } else {
                self.showViewControllerAlongsideTransition(vc, isInteractive: context.isInteractive)
            }
        }) { [weak self] (context) in
            guard let self = self else {
                return
            }
            self.isTransitional = false
            if context.isCancelled {
                self.updateNavigationBarStyle(for: from)
            } else {
                self.updateNavigationBarStyle(for: vc)
            }
            if to == vc {
                self.removePlaceholderBar()
            }
        }
        
        if coordinator.isInteractive {
            coordinator.notifyWhenInteractionChanges { [weak self] (context) in
                guard let self = self else {
                    return
                }
                if context.isCancelled {
                    self.updateNavigationBarAttributes(for: from)
                } else {
                    self.updateNavigationBarAttributes(for: vc)
                }
            }
        }
    }
    
    func showViewControllerAlongsideTransition(_ vc: UIViewController, isInteractive: Bool) {
        self.gp_navigationBar.barStyle = vc.gp_naviBarStyle
        self.gp_navigationBar.titleTextAttributes = vc.gp_naviTitleTextAttributes
        if !isInteractive {
            self.gp_navigationBar.tintColor = vc.gp_naviTintColor
        }
        
        updateNavigationBarAlpha(for: vc)
        updateNavigationBarTintColorOrImage(for: vc)
        updateNavigationBarShadowAlpha(for: vc)
    }
    
    func showViewControllerAlongsideTransition(_ vc: UIViewController, from: UIViewController, to: UIViewController, isInteractive: Bool) {
        navigationBar.titleTextAttributes = vc.gp_naviTitleTextAttributes
        navigationBar.barStyle = vc.gp_naviBarStyle
        if !isInteractive {
            gp_navigationBar.tintColor = vc.gp_naviTintColor
        }
        addPaceholderBarTo(from: from, to: to)
    }
}


// MARK: - Handle Events
extension GPNavigationController {
    @objc func onClickBackBtn(sender: UIButton) {
        guard let isEnabled = topViewController?.gp_clickBackEnabled, isEnabled else {
            return
        }
        
        if let handler = topViewController?.gp_naviBackActionHandler {
            handler(sender)
        } else {
            let _ = self.popViewController(animated: true)
        }
    }
    
    @objc func onPopGesture(sender: UIScreenEdgePanGestureRecognizer) {
        guard let from = transitionCoordinator?.viewController(forKey: .from), let to = transitionCoordinator?.viewController(forKey: .to) else {
            return
        }
        
        guard  let percent = transitionCoordinator?.percentComplete else {
            return
        }
        
        let fromColor = from.gp_naviTintColor
        let toColor = to.gp_naviTintColor
        if sender.state == .began || sender.state == .changed {
            navigationBar.tintColor = color(from: fromColor, to: toColor, percent: Float(percent))
        }
    }
}


// MARK: - UINavatigationBarDelegate
extension GPNavigationController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        setupBackNavigationBarItem(for: viewController)
        isTransitional = true
        navigationBar.titleTextAttributes = viewController.gp_naviTitleTextAttributes
        gp_navigationBar.barStyle = viewController.gp_naviBarStyle
        
        if let coordinator = transitionCoordinator {
            showViewController(viewController, with: coordinator)
        } else {
            if !animated && viewControllers.count > 1 {
                let lastOne = viewControllers[viewControllers.count - 2]
                let isShowPlaceholder = self.shouldAddPlaceholderBar(on: viewController, from: lastOne, to: viewController)
                if isShowPlaceholder {
                    self.addPaceholderBarTo(from: lastOne, to: viewController)
                    return
                }
            }
            updateNavigationBarStyle(for: viewController)
        }
    }
    
    public func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        self.isTransitional = false
        if !animated {
            updateNavigationBarStyle(for: viewController)
            removePlaceholderBar()
        }
        popingViewController = nil
    }
}

// MARK: - UIGestureRecognizerDelegate
extension GPNavigationController: UIGestureRecognizerDelegate {
    // 侧滑返回手势开启条件
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return !isTransitional && viewControllers.count > 1 && ( topViewController?.gp_swipeBackEnbaled ?? true)
    }
    
    // 解决滑动返回与其他手势冲突
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRequireFailureOf otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer === self.interactivePopGestureRecognizer, self.topViewController?.gp_swipeBackEnbaled ?? true {
            otherGestureRecognizer.require(toFail: gestureRecognizer)
            return false
        }
        return true
    }
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if gestureRecognizer === self.interactivePopGestureRecognizer {
            return self.topViewController?.gp_swipeBackEnbaled ?? true
        }
        return true
    }
}

// MARK: - UINavigationBarDelegate
extension GPNavigationController: UINavigationBarDelegate {
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        if self.viewControllers.count > 1 {
            if let topVC = topViewController, let topNaviItem = topViewController?.navigationItem, topNaviItem == item {
                let isPop = topVC.gp_clickBackEnabled
                if !isPop {
                    resetSubviews(in: self.navigationBar)
                    return false
                }
            }
        }
        return true
    }
}

// MARK: - Other
extension GPNavigationController {
    
    /// 判断是否在过度过程中显示占位的导航控制器
    ///
    /// - Parameters:
    ///   - willShowViewController: 将要显示的控制权
    ///   - from: 源控制器
    ///   - to: 目标控制器
    func shouldAddPlaceholderBar(on willShowViewController: UIViewController, from: UIViewController, to: UIViewController) -> Bool {
        if willShowViewController != to {
            return false
        }
        
        if nil != from.gp_naviBarImage && nil != to.gp_naviBarImage && image(from.gp_naviBarImage, isEqualTo: to.gp_naviBarImage) {
            return abs(from.gp_naviBarAlpha - to.gp_naviBarAlpha) > 0.1
        }
        
        if nil == from.gp_naviBarImage && nil == to.gp_naviBarImage && from.gp_computedNaviBarTintColor?.description == to.gp_computedNaviBarTintColor?.description {
            return abs(from.gp_naviBarAlpha - to.gp_naviBarAlpha) > 0.1
        }
        
        return true
    }
    
    ///  判断两张图片是否相等
    ///
    /// - Parameters:
    ///   - image0: 图片1
    ///   - image1: 图片2
    func image(_ image0: UIImage?, isEqualTo image1: UIImage?) -> Bool {
        
        if image0 == image1 {
            return true
        }
        
        if nil != image0 && nil != image1 {
            let image0Data = image0?.jpegData(compressionQuality: 1)
            let image1Data = image1?.jpegData(compressionQuality: 1)
            return image0Data == image1Data
        }
        return false
    }
    
    /// 根据当前滑动的百分比，创建中间颜色
    ///
    /// - Parameters:
    ///   - from: 源颜色
    ///   - to: 目标颜色
    ///   - percent: 滑动的百分比
    /// - Returns: 当前导航栏颜色
    func color(from: UIColor, to: UIColor, percent: Float) -> UIColor {
        var fromRed: CGFloat = 0
        var fromGreen: CGFloat = 0
        var fromBlue: CGFloat = 0
        var fromAlpha: CGFloat = 0
        from.getRed(&fromRed, green: &fromGreen, blue: &fromBlue, alpha: &fromAlpha)
        
        var toRed: CGFloat = 0
        var toGreen: CGFloat = 0
        var toBlue: CGFloat = 0
        var toAlpha: CGFloat = 0
        to.getRed(&toRed, green: &toGreen , blue: &toBlue, alpha: &toAlpha)
        
        let validPercent = CGFloat(fminf(1, percent * 4))
        let currentRed = fromRed + (toRed - fromRed) * validPercent
        let currentGreen = fromGreen + (toGreen - fromGreen) * validPercent
        let currrentBlue = fromBlue + (toBlue - fromBlue) * validPercent
        let currentAlpha = fromAlpha + (toAlpha - fromAlpha) * validPercent
        return UIColor(red: currentRed, green: currentGreen, blue: currrentBlue, alpha: currentAlpha)
    }
    
    /// 判断是否为iPhone X系列
    ///
    /// - Returns: true / false
    func isIphoneX() -> Bool {
        return max(UIScreen.main.bounds.width, UIScreen.main.bounds.height) > 800
    }
}
