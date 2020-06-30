//
//  TopBarView.swift
//  Mine
//
//  Created by bailun on 2020/6/30.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

class TopBarView: UIView {
    
    var onClickQrButtonHandler: (() -> Void)?
    var onClickWriteButtonHandler: (() -> Void)?
    
    /// 扫描二维码
    lazy var qrBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(R.image.mine_main_qr(), for: .normal)
        button.addTarget(self, action: #selector(onClickQrBtnEvent), for: .touchUpInside)
        return button
    }()
    
    lazy var writeBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(R.image.mine_main_write(), for: .normal)
        button.addTarget(self, action: #selector(onClickWriteBtnEvent), for: .touchUpInside)
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "我的"
        label.font = UIFont.AdaptiveBoldFont(size: 18)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSubviews()
        setupSubviewsContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(qrBtn)
        addSubview(writeBtn)
        addSubview(titleLabel)
    }
    
    private func setupSubviewsContraints() {
        let offsetX = 20.0
        
        qrBtn.snp.makeConstraints { (make) in
            make.left.equalTo(offsetX)
            make.centerY.equalToSuperview().offset(GPConstant.kToolBarHeight)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        writeBtn.snp.makeConstraints { (make) in
            make.right.equalTo(-offsetX)
            make.centerY.equalTo(qrBtn)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        
        titleLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(qrBtn)
        }
    }
    
}

extension TopBarView {
    @objc func onClickQrBtnEvent() {
        if let block = onClickQrButtonHandler {
            block()
        }
    }
    
    @objc func onClickWriteBtnEvent() {
        if let block = onClickWriteButtonHandler {
            block()
        }
    }
}
