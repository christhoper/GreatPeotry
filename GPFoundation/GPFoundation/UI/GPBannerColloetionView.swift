//
//  GPBannerColloetionView.swift
//  GPFoundation
//
//  Created by bailun on 2020/8/8.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit
import Kingfisher
import SnapKit

public class GPBannerColloetionView: UICollectionView {
    public var urls: [String] = [String]()
    
    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        delegate = self
        dataSource = self
        self.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.identifier)
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func refreshCellData() {
        self.reloadData()
    }
}

extension GPBannerColloetionView: UICollectionViewDelegate {
    
}

extension GPBannerColloetionView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return urls.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.identifier, for: indexPath) as! BannerCollectionViewCell
        let url = urls[indexPath.row]
        cell.loadImage(for: url)
        return cell
    }
}


 class BannerCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "BannerCollectionViewCell"
    
    lazy var contentImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(contentImageView)
        contentView.backgroundColor = .white
        contentImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadImage(for url: String) {
        contentImageView.kf.setImage(with: URL(string: url), placeholder: nil, options: [.fromMemoryCacheOrRefresh])
    }
}



