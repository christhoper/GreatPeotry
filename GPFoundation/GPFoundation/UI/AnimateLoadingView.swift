//
//  AnimateLoadingView.swift
//  GPFoundation
//
//  Created by bailun on 2020/5/15.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

public class AnimateLoadingView: UIView {
    
    public static let  `default` = AnimateLoadingView.init()
    
    override open class var layerClass: AnyClass {
        return CAGradientLayer.classForCoder()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
    private func setup(){
        if let gradientLayer = self.layer as?  CAGradientLayer {
            let beginColor = UIColor.white.withAlphaComponent(0.05).cgColor
            let endColor = UIColor.white.withAlphaComponent(0.4).cgColor
            gradientLayer.startPoint = CGPoint.init(x: 0, y: 0.5)
            gradientLayer.endPoint = CGPoint.init(x: 1, y: 0.5)
            gradientLayer.colors = [beginColor,endColor,beginColor]
        }
    }
    
    public func startLoading(in parent: UIView , inset: UIEdgeInsets = UIEdgeInsets.zero){
        self.removeFromSuperview()
        parent.addSubview(self)
        self.frame = CGRect.init(x: inset.left, y: inset.top, width: 70, height: parent.frame.height - inset.top - inset.bottom)
        //add animate
        let animation = CABasicAnimation(keyPath: "position.x")
        animation.duration = CFTimeInterval(parent.frame.width/400.0)
        animation.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        animation.repeatCount = .infinity
        animation.fromValue = inset.left
        animation.toValue = parent.frame.width - inset.right
        self.layer.add(animation, forKey: "loading")
    }
    
    public func endLoadind(){
        self.layer.removeAllAnimations()
        self.removeFromSuperview()
    }
    
}
