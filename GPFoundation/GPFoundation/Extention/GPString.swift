//
//  GPString.swift
//  GPFoundation
//
//  Created by bailun on 2020/8/7.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit


public extension String {
    /// 计算文本高度
    static func caculateHeight(content: String, maxWidth: CGFloat, font: UIFont) -> CGFloat {
        guard content.count > 0 && maxWidth > 0 else {
            return 0.0
        }
        
        let option = NSStringDrawingOptions.usesLineFragmentOrigin
        let attributes: [NSAttributedString.Key : Any] = [NSAttributedString.Key.font: font]
        let stringRect = content.boundingRect(with: CGSize(width: maxWidth, height: CGFloat(Int.max)), options: option, attributes: attributes , context: nil)
        return CGFloat(ceil(stringRect.size.height))
    }
    
}
