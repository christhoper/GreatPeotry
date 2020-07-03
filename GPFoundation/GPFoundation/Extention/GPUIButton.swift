//
//  GPUIButton.swift
//  GPFoundation
//
//  Created by bailun on 2020/7/1.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit

public extension UIButton {
    enum GPButtonEdgeInsetsEnum {
        /// image在上，label在下
        case imageUpLabelDown
        /// image在下，label在上
        case imageDownLabelUp
        /// image在左，label在右
        case imageLeftLabelRight
        /// image在右，label在左
        case imageRightLabelLeft
    }
    
    func setupButtomImage_LabelStyle(style: GPButtonEdgeInsetsEnum, imageTitleSpace: CGFloat) {
        //  imageView和titleLabel的宽、高
        let imgW = self.imageView?.frame.size.width ?? 0.0
        let imgH = self.imageView?.frame.size.height ?? 0.0
        let orgLabW = self.titleLabel?.frame.size.width ?? 0.0
        let orgLabH = self.titleLabel?.frame.size.height ?? 0.0
        
        let trueSize = self.titleLabel?.sizeThatFits(CGSize(width: CGFloat.greatestFiniteMagnitude, height: CGFloat.greatestFiniteMagnitude))
        let trueLabW = trueSize?.width ?? 0.0
        
        //image中心移动的x距离
        let imageOffsetX = orgLabW / 2.0
        //image中心移动的y距离
        let imageOffsetY = orgLabH / 2.0 + imageTitleSpace / 2.0
        //label左边缘移动的x距离
        let labelOffsetX1 = imgW / 2.0 - orgLabW / 2.0 + trueLabW / 2.0
        //label右边缘移动的x距离
        let labelOffsetX2 = imgW / 2.0 + orgLabW / 2.0 - trueLabW / 2.0
        //label中心移动的y距离
        let labelOffsetY = imgH / 2.0 + imageTitleSpace / 2.0
        
        var imageEdgeInsets: UIEdgeInsets = .zero
        var labelEdgeInsets: UIEdgeInsets = .zero
        
        switch (style) {
        case .imageUpLabelDown:
            imageEdgeInsets = UIEdgeInsets(top: -imageOffsetY, left: imageOffsetX, bottom: imageOffsetY, right: -imageOffsetX)
            labelEdgeInsets = UIEdgeInsets(top: labelOffsetY, left: -labelOffsetX1, bottom: -labelOffsetY, right: labelOffsetX2)
            
        case .imageDownLabelUp:
            imageEdgeInsets = UIEdgeInsets(top: imageOffsetY, left: imageOffsetX, bottom: -imageOffsetY, right: -imageOffsetX)
            labelEdgeInsets = UIEdgeInsets(top: -labelOffsetY, left: -labelOffsetX1, bottom: labelOffsetY, right: labelOffsetX2)
            
        case .imageLeftLabelRight:
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: -imageTitleSpace / 2.0, bottom: 0.0, right: imageTitleSpace / 2.0)
            labelEdgeInsets = UIEdgeInsets(top: 0.0, left: imageTitleSpace / 2.0, bottom: 0.0, right: -imageTitleSpace / 2.0)
            
        case .imageRightLabelLeft:
            imageEdgeInsets = UIEdgeInsets(top: 0.0, left: orgLabW + imageTitleSpace / 2.0, bottom: 0.0, right: -(orgLabW + imageTitleSpace / 2.0))
            labelEdgeInsets = UIEdgeInsets(top: 0.0, left: -(imgW + imageTitleSpace / 2.0), bottom: 0.0, right: imgW + imageTitleSpace / 2.0)
        }
        
        self.imageEdgeInsets = imageEdgeInsets
        self.titleEdgeInsets = labelEdgeInsets
    }
}

func associatedObject<T> (base: AnyObject, key: UnsafePointer<UInt8>, initialiser: () -> T) -> T {
        if let associated = objc_getAssociatedObject(base, key)
            as? T { return associated }
        let associated = initialiser()
        objc_setAssociatedObject(base, key, associated,
                                 .OBJC_ASSOCIATION_RETAIN)
        return associated
}

func associateObject<T> (base: AnyObject, key: UnsafePointer<UInt8>, value: T) {
    objc_setAssociatedObject(base, key, value,
                             .OBJC_ASSOCIATION_RETAIN)
}

private var topKey: UInt8 = 0
private var bottomKey: UInt8 = 0
private var leftKey: UInt8 = 0
private var rightKey: UInt8 = 0

public extension UIButton {
    var top: NSNumber {
        get {
            return associatedObject(base: self, key: &topKey)
            { return 0 }
        }
        set {
            associateObject(base: self, key: &topKey, value: newValue)
        }
    }
    
    var bottom: NSNumber {
        get {
            return associatedObject(base: self, key: &bottomKey)
            { return 0 }
        }
        set {
            associateObject(base: self, key: &bottomKey, value: newValue)
        }
    }
    
    var left: NSNumber {
        get {
            return associatedObject(base: self, key: &leftKey)
            { return 0 }
        }
        set {
            associateObject(base: self, key: &leftKey, value: newValue)
        }
    }
    
    var right: NSNumber {
        get {
            return associatedObject(base: self, key: &rightKey)
            { return 0 }
        }
        set {
            associateObject(base: self, key: &rightKey, value: newValue)
        }
    }
    
    
    /// 设置按钮的点击范围
    /// - Parameters:
    ///   - top: 居顶距离
    ///   - bottom: 居底距离
    ///   - left: 居左距离
    ///   - right: 居右距离
    /// - Returns: <#description#>
    func setEnlargeEdge(top: Float, bottom: Float, left: Float, right: Float) -> Void {
        self.top = NSNumber.init(value: top)
        self.bottom = NSNumber.init(value: bottom)
        self.left = NSNumber.init(value: left)
        self.right = NSNumber.init(value: right)
    }
    
    func enlargedRect() -> CGRect {
        let top = self.top
        let bottom = self.bottom
        let left = self.left
        let right = self.right
        if top.floatValue >= 0, bottom.floatValue >= 0, left.floatValue >= 0, right.floatValue >= 0 {
            return CGRect.init(x: self.bounds.origin.x - CGFloat(left.floatValue),
                               y: self.bounds.origin.y - CGFloat(top.floatValue),
                               width: self.bounds.size.width + CGFloat(left.floatValue) + CGFloat(right.floatValue),
                               height: self.bounds.size.height + CGFloat(top.floatValue) + CGFloat(bottom.floatValue))
        } else {
            return self.bounds
        }
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = self.enlargedRect()
        if rect.equalTo(self.bounds) {
            return super.point(inside: point, with: event)
        }
        return rect.contains(point) ? true : false
    }
}
