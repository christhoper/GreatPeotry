//
//  MainPageTableViewCell.swift
//  Creation
//
//  Created by jhd on 2020/8/8.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

class MainPageTableViewCell: UITableViewCell {

    static let identifier = "MainPageTableViewCell"
    
    lazy var coverImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(red: 235/255.0, green: 239/255.0, blue: 241/255.0, alpha: 1.0)
        imageView.layer.cornerRadius = 4.0
        imageView.isSkeletonable = true
        return imageView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "啊飒飒大所大所大所大大所大所多"
        label.textColor = UIColor.gray51
        label.font = UIFont.AdaptiveBoldFont(size: 16)
        label.numberOfLines = 2
        label.isSkeletonable = true
        return label
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "12:20"
        label.textColor = UIColor.gray102
        label.numberOfLines = 0
        label.font = UIFont.AdaptiveRegularFont(size: 12)
        label.isSkeletonable = true
        return label
    }()
    
    lazy var countLabel: UILabel = {
        let label = UILabel()
        label.text = "32131321313131"
        label.textColor = UIColor.gray153
        label.font = UIFont.AdaptiveRegularFont(size: 12)
        label.isSkeletonable = true
        return label
    }()
        
    lazy var countImgView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.main_count()
        imageView.clipsToBounds = true
        imageView.isSkeletonable = true
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
        self.setupSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews(){
        contentView.backgroundColor = UIColor.white
        selectionStyle = .none
        contentView.addSubview(titleLabel)
        contentView.addSubview(coverImgView)
        contentView.addSubview(timeLabel)
        contentView.addSubview(countImgView)
        contentView.addSubview(countLabel)
        
        setupSubviewContaints()
    }
    
    func setupSubviewContaints() {
        coverImgView.snp.makeConstraints { (make) in
            make.width.equalTo(120)
            make.height.equalTo(90)
            make.left.equalTo(20)
            make.centerY.equalToSuperview()
        }
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(coverImgView)
            make.left.equalTo(coverImgView.snp.right).offset(12).priority(999)
            make.right.equalTo(-20)
        }
        timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(titleLabel)
            make.height.equalTo(17)
            make.bottom.equalTo(coverImgView)
        }
        countLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.height.equalTo(timeLabel)
            make.centerY.equalTo(timeLabel)
        }
        countImgView.snp.makeConstraints { (make) in
            make.right.equalTo(countLabel.snp.left).offset(-4)
            make.height.equalTo(20)
            make.width.equalTo(20)
            make.centerY.equalTo(timeLabel)
        }
    }
    
    func setupModel(_ model: MainPageEntity) {
        coverImgView.kf.setImage(with: URL(string: model.titleImg),
                                 placeholder: R.image.main_placeholder())
        timeLabel.text = String.formatDate(TimeInterval(Int(model.upTime)))
        titleLabel.text = model.title
        countLabel.text = model.clicks.toCountFormatterStringWithLocalLanguage()
    }
    
}
