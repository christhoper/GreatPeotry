//
//  LoadingView.swift
//  Home
//
//  Created by bailun on 2020/5/15.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit


enum LoadingType {
    case `default`
    case custom
    
    var elementCount: Int {
        switch self {
        case .default:
            return 6
        case .custom:
            return 4
        }
    }
    
    var elementHeight: CGFloat {
        switch self {
        case .default:
            return 120.0
        case .custom:
            return 170.0
        }
    }
}

class LoadingView: UIView {
    
    var type: LoadingType = .default {
        didSet {
            self.setupSubviews()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
       
    }
    
    // MARK: Private method
    func setupSubviews() {
        let width = UIScreen.main.bounds.size.width
        for count in 0...type.elementCount {
            let element = ElementLoadingView(frame: CGRect(x: 0, y: CGFloat(count)*type.elementHeight, width: width, height: type.elementHeight), loadingType: self.type)
            self.addSubview(element)
        }
    }
}


class ElementLoadingView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    convenience init(frame: CGRect, loadingType: LoadingType) {
        self.init(frame: frame)
        if loadingType == .default {
            self.setupSubviews()
        } else {
            self.setupDynamicLoadingView()
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    private func setupSubviews(){

        self.isSkeletonable = true
        self.backgroundColor = UIColor.white
        let grayColor = UIColor.gray235
        let cornerRadius = CGFloat(3.0)
        
        
        let view1 = UIView()
        view1.layer.cornerRadius = cornerRadius
        view1.backgroundColor = grayColor
        view1.clipsToBounds = true
        view1.isSkeletonable = true
        
        
        let view2 = UIView()
        view2.backgroundColor = grayColor
        view2.layer.cornerRadius = cornerRadius
        view2.clipsToBounds = true
        view2.isSkeletonable = true
        
        let view3 = UIView()
        view3.backgroundColor = grayColor
        view3.layer.cornerRadius = cornerRadius
        view3.clipsToBounds = true
        view3.isSkeletonable = true
        
        let view4 = UIView()
        view4.backgroundColor = grayColor
        view4.layer.cornerRadius = cornerRadius
        view4.clipsToBounds = true
        view4.isSkeletonable = true
        
        let view5 = UIView()
        view5.backgroundColor = grayColor
        view5.layer.cornerRadius = cornerRadius
        view5.clipsToBounds = true
        view5.isSkeletonable = true
        
        self.addSubview(view1)
        self.addSubview(view2)
        self.addSubview(view3)
        self.addSubview(view4)
        self.addSubview(view5)
        
        view1.snp.makeConstraints { (maker) in
            maker.top.equalTo(15)
            maker.leading.equalTo(20)
            maker.height.equalTo(90)
            maker.width.equalTo(120)
        }
        view2.snp.makeConstraints { (maker) in
            maker.top.equalTo(view1.snp.top).offset(5)
            maker.leading.equalTo(view1.snp.trailing).offset(12)
            maker.trailing.equalTo(-20)
            maker.height.equalTo(15)
        }
        view3.snp.makeConstraints { (maker) in
            maker.top.equalTo(view2.snp.bottom).offset(10)
            maker.leading.trailing.height.equalTo(view2)
        }
        view4.snp.makeConstraints { (maker) in
            maker.leading.equalTo(view3)
            maker.bottom.equalTo(view1.snp.bottom).offset(-5)
            maker.height.equalTo(15)
            maker.width.equalTo(60)
        }
        view5.snp.makeConstraints { (maker) in
            maker.trailing.equalTo(view3)
            maker.bottom.equalTo(view4)
            maker.height.equalTo(15)
            maker.width.equalTo(30)
        }
    }
    
    private func setupDynamicLoadingView() {
        self.backgroundColor = UIColor.white
        let grayColor = UIColor.gray235
        self.isSkeletonable = true
        
        let view1 = UIView()
        view1.layer.cornerRadius = 4.0
        view1.backgroundColor = grayColor
        view1.clipsToBounds = true
        view1.isSkeletonable = true
        
        let view2 = UIView()
        view2.backgroundColor = grayColor
        view2.layer.cornerRadius = 3.0
        view2.clipsToBounds = true
        view2.isSkeletonable = true
        
        let view3 = UIView()
        view3.backgroundColor = grayColor
        view3.layer.cornerRadius = 3.0
        view3.clipsToBounds = true
        view3.isSkeletonable = true
        
        let view4 = UIView()
        view4.backgroundColor = grayColor
        view4.layer.cornerRadius = 3.0
        view4.clipsToBounds = true
        view4.isSkeletonable = true
        
        let view5 = UIView()
        view5.backgroundColor = grayColor
        view5.layer.cornerRadius = 3.0
        view5.clipsToBounds = true
        view5.isSkeletonable = true
        
        let view6 = UIView()
        view6.backgroundColor = grayColor
        view6.layer.cornerRadius = 3.0
        view6.clipsToBounds = true
        view6.isSkeletonable = true
        
        self.addSubview(view1)
        self.addSubview(view2)
        self.addSubview(view3)
        self.addSubview(view4)
        self.addSubview(view5)
        self.addSubview(view6)
        
        view1.snp.makeConstraints { (maker) in
            maker.top.equalTo(8)
            maker.left.equalToSuperview().offset(20)
            maker.size.equalTo(CGSize(width: 40, height: 40))
        }
        let width = UIScreen.main.bounds.size.width - CGFloat(40)
        view2.snp.makeConstraints { (maker) in
            maker.top.equalTo(8)
            maker.left.equalTo(view1.snp.right).offset(12)
            maker.size.equalTo(CGSize(width: 40, height: 15))
        }
        view3.snp.makeConstraints { (maker) in
            maker.bottom.equalTo(view1.snp.bottom)
            maker.left.equalTo(view2)
            maker.size.equalTo(CGSize(width: 130, height: 15))
        }
        view4.snp.makeConstraints { (maker) in
            maker.top.equalTo(view1.snp.bottom).offset(15)
            maker.left.equalTo(view1)
            maker.size.equalTo(CGSize(width: width, height: 15))
        }
        view5.snp.makeConstraints { (maker) in
            maker.top.equalTo(view4.snp.bottom).offset(15)
            maker.left.equalTo(view1)
            maker.size.equalTo(CGSize(width: width, height: 15))
        }
        view6.snp.makeConstraints { (maker) in
            maker.top.equalTo(view5.snp.bottom).offset(15)
            maker.leading.equalTo(view1)
            maker.size.equalTo(CGSize(width: width - 50, height: 15))
        }
    }
}
