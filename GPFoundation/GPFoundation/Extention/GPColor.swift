//
//  GPColor.swift
//  GPFoundation
//
//  Created by jhd on 2020/4/28.
//  Copyright © 2020 hend. All rights reserved.
//

import UIKit

public extension UIColor {
    static let gray51 = rgbColor(51, 51, 51)
    static let gray102 = rgbColor(102, 102, 102)
    static let gray153 = rgbColor(153, 153, 153)
    static let gray204 = rgbColor(204, 204, 204)
    static let gray216 = rgbColor(216, 216, 216)
    static let gray235 = rgbColor(235, 235, 235)
    static let gray238 = rgbColor(238, 238, 238)
    static let gray243 = rgbColor(243, 243, 243)
    static let gray245 = rgbColor(245, 245, 245)
    
    static let mainColor = rgbColor(0, 190, 190)
    static let bgColor = rgbColor(245, 245, 245)
    static let blackTextColor = rgbColor(51, 51, 51)
    static let blueTextColor = rgbColor(39, 97, 181)
    static let blueTextColor06 = rgbColor(39, 97, 181, 0.6)
    static let lightBlueColor = rgbColor(125, 160, 211)
    static let redTextColor = rgbColor(254, 121, 75)
    static let lineColor = rgbColor(229, 229, 229)
    static let yellowTextColor = rgbColor(226, 193, 128)
    /// 全局蓝色
    static let globalBlue = UIColor(hex: 0x2761B5)
    /// 全局黑色
    static let globalBlack = UIColor(hex: 0x333333)
    /// 描边颜色
    static let borderColor = UIColor(hex: 0xF3F3F3)
}

public extension UIColor {
    /// Init a color with red,green,blue,alpha value. eg: UIColor(red: 46, green: 169, blue: 223, alpha: 1.0)
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(red)/255.0, green: CGFloat(green)/255.0, blue: CGFloat(blue)/255.0, alpha: alpha)
    }
    
    convenience init (white: Int, alpha: CGFloat = 1.0) {
        self.init(white: CGFloat(white)/255.0, alpha: alpha)
    }
    
    /// Init a color hex value value. eg: UIColor(hex: 0x2ea9df)
    convenience init(hex: Int, alpha: CGFloat = 1.0) {
        let red = (hex >> 16) & 0xFF
        let green = (hex >> 8) & 0xFF
        let blue = hex & 0xFF
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    static func rgbColor(_ red: Int, _ green: Int, _ blue: Int, _ alpha: CGFloat = 1.0) -> UIColor {
        return UIColor(red: red, green: green, blue: blue, alpha: alpha)
    }
}
