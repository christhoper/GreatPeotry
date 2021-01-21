//
//  GPString.swift
//  GPFoundation
//
//  Created by bailun on 2020/8/7.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit
import CryptoSwift
import CommonCrypto

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


public extension String {
    
    static func dateToString(_ date: Date, dateFormat: String = "yyyy-MM-dd HH:mm:ss") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        let dateString = formatter.string(from: date as Date)
        return dateString
    }
    
    /// 时间戳转化成时间
    static func formatDate(_ timeInval: TimeInterval) -> String {
        let recent = "刚刚"
        let minutesAgo = "分钟前"
        let hoursAgo = "小时前"
        let weekAgo = "周前"
        let weeksAgo = "周前"
        let daysAgo = "天前"
        let monthsAgo = "月前"
        let yearsAgo = "年前"
        
        //获取当前的时间戳
        let currentTime = Date().timeIntervalSince1970
        let reduceTime : TimeInterval = currentTime - timeInval
        
        let minute: TimeInterval = 60
        let hour: TimeInterval = 60*minute
        let day: TimeInterval = 24*hour
        let week: TimeInterval = 7*day
        let month: TimeInterval = 30*day
        let year: TimeInterval = 365*day
        
        var dateString = ""
        switch reduceTime {
        case 0..<minute:
            dateString = recent
        case minute..<hour:
            dateString = "\(Int(reduceTime / minute))"+minutesAgo
        case hour..<day:
            dateString = "\(Int(reduceTime / hour))"+hoursAgo
        case day..<week:
            dateString = "\(Int(reduceTime / day))"+daysAgo
        case week..<2*week:
            dateString = "\(Int(reduceTime / week))"+weekAgo
        case 2*week..<month:
            dateString = "\(Int(reduceTime / week))"+weeksAgo
        case month..<year:
            dateString = "\(Int(reduceTime / month))"+monthsAgo
        default:
            dateString = "\(Int(reduceTime / year))"+yearsAgo
            break
        }
        
        return dateString
    }
}

public extension String {
    
    func aesEncrypt(key: String, iv: String) -> String {
        var result = ""
        do {
            let enc = try AES(key: Array(key.utf8), blockMode: CBC(iv: Array(iv.utf8)), padding: .zeroPadding).encrypt(Array(self.utf8))
            let encData = Data(bytes: enc, count: Int(enc.count))
            let base64String = encData.base64EncodedString()
            result = String(base64String)
        } catch {
            print("Error: \(error)")
        }
        return result
    }

    func aesDecrypt(key: String, iv: String) -> String {
        var result = ""
        do {
            guard let data = Data(base64Encoded: self) else { return result}
            let dec = try AES(key: Array(key.utf8), blockMode: CBC(iv: Array(iv.utf8)), padding: .zeroPadding).decrypt(Array(data))
            let decData = Data(bytes: dec, count: Int(dec.count))
            result = String(data: decData, encoding: .utf8) ?? ""
        } catch {
            print("Error: \(error)")
        }
        return result
    }
}
