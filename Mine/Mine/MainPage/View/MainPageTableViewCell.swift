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
        label.text = "标题"
        return label
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
        self.defaultConfigure()
        self.setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    
}
