//
//  MainPageTableViewCell.swift
//  Mine
//
//  Created by bailun on 2020/6/24.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

class MainPageTableViewCell: UITableViewCell {
    
    static let identifier = "MainPageTableViewCell"
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.defaultConfigure()
        label.text = "标题"
        return label
    }()
    
    lazy var cominImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.mine_main_comein()
        return imageView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        defaultConfigure()
        setupSubviews()
        setupSubviewsContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(cominImageView)
    }
    
    private func setupSubviewsContraints() {
        let offsetX: CGFloat = 20
        
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(UIEdgeInsets(top: 0, left: offsetX, bottom: 0, right: 32))
        }
    
        cominImageView.snp.makeConstraints { (make) in
            make.right.equalTo(-offsetX)
            make.centerY.equalToSuperview()
            make.size.equalTo(CGSize(width: 12, height: 12))
        }
    }
}

extension MainPageTableViewCell {
    func setupCellDataSource(for title: String) {
        titleLabel.text = title
    }
}
