//
//  GPInt64.swift
//  GPFoundation
//
//  Created by bailun on 2020/8/8.
//  Copyright © 2020 Baillun. All rights reserved.
//

import Foundation


public extension Int64 {
    
    func toCountFormatterStringWithLocalLanguage() -> String {
        return toCountChineseString(isSimplified: true)
    }
    
    private func toCountEnglishString() -> String {
        let kUnit = "K"
        let mUnit = "M"
        let bUnit = "B"
        
        let bValue: Int64 = 100
        let kValue: Int64 = 1000
        let wValue: Int64 = 10*kValue
        let bwValue: Int64 = 100*wValue
        let qwValue: Int64 = 1000*wValue
        let yValue: Int64 = 1_0000_0000
        let syValue: Int64 = 10*yValue
        let byValue: Int64 = 100*yValue
        
        switch self {
        case 0...(kValue-1):
            return "\(self)"
        case kValue...(wValue-1):
            return "\(self/kValue)"+"."+"\(self%kValue/bValue)"+kUnit
        case wValue...(bwValue-1):
            return "\(self/kValue)"+kUnit
        case bwValue...(qwValue-1):
            return "\(self/bwValue)"+"."+"\(self%bwValue/(10*wValue))"+mUnit
        case qwValue...(syValue-1):
            return "\(self/bwValue)"+mUnit
        case syValue...(byValue-1):
            return "\(self/syValue)"+"."+"\(self%syValue/(syValue/10))"+bUnit
        case byValue...Int64.max-1:
            return "\(self/syValue)"+bUnit
        default:
            return ""
        }
    }
    
    private func toCountChineseString(isSimplified: Bool) -> String {
        let wanUnit = isSimplified ? "万" : "萬"
        let yiUnit = isSimplified ? "亿" : "億"
        
        let wValue: Int64 = 1_0000
        let yValue: Int64 = 1_0000_0000
        
        switch self {
        case 0...(wValue-1):
            return "\(self)"
        case wValue...(10*wValue-1):
            return "\(self/10000)"+"."+"\(self%10000/1000)"+wanUnit
        case 10*wValue...(yValue-1):
            return "\(self/wValue)"+wanUnit
        case yValue...Int64.max-1:
            return "\(self/yValue)"+"."+"\(self%yValue/(yValue/10))"+yiUnit
        default:
            return ""
        }
    }
}
