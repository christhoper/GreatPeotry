//
//  NetworkConfigure.swift
//  GPFoundation
//
//  Created by bailun on 2021/1/21.
//  Copyright © 2021 Baillun. All rights reserved.
//

import Foundation


extension GPHttpManager {
    
    /// 设置Http请求头
    public func setHttpHeaders() {
        var headers = [String : String]()
        // 随机数(6位数)
        let random: Int = Int(arc4random() % 999999 + 100000)
        let timestamp = setupTimestamp()
        let secret = setupSecret()
        
        headers["locallanguage"] = "1"
        headers["clientType"] = "1"
        headers["TS"] = "\(timestamp)"
        headers["RD"] = "\(random)"
        headers["AK"] = defaultAK.aesEncrypt(key: "1437030755202316", iv: "7789977142035609")
        let md5 = MD5("\(defaultAK + "-\(timestamp)" + "-\(random)-" + secret)")
        headers["TK"] = getNewMD5ByRandonNumber(random, md5)
        
        GPHttpManager.shared.configGeneralHeaderHandle { () -> [String : String] in
            return headers
        }
    }

    /// 设置Secret
    func setupSecret() -> String {
        return "Fazzaco@123.test"
    }

    /// 设置时间戳，精确到毫秒
    func setupTimestamp() -> CLongLong {
        let timestamp = Date(timeIntervalSinceNow: 0).timeIntervalSince1970
        let millisecond = CLongLong(round(timestamp * 1000))
        return millisecond
    }

    /// 默认的AK
    var defaultAK: String {
        "7a3cf298efde4a86a52a109267d3817e"
    }

    /// 和后台约定的模板
    var charBoard: [String] {
        ["E", "p", "B", "y", "m", "6", "n", "v", "U", "s",
         "8", "l", "Y", "x", "C", "q", "7", "b", "W", "i",
         "N", "2", "u", "o", "V", "g", "D", "9", "a", "G",
         "A", "1", "I", "M", "d", "0", "z", "k", "X", "t",
         "S", "f", "5", "J", "c", "Z", "O", "r", "H", "w",
         "P", "3", "F", "R", "L", "T", "e", "4", "Q", "h",
         "K", "j"]
    }

    /// 将RD字段的随机数转换成数字，对模板的长度取余数，获取余数下标的字符
    func getCharByRandonNumber(_ number: Int) -> String {
        let index: Int = number % charBoard.count
        return charBoard[safe: index] ?? ""
    }

    /// 再将取到的字符插入到md5加密之后字符串中，插入位置为随机数对md5字符串取余数，插入到余数的位置
    func getNewMD5ByRandonNumber(_ number: Int, _ md5String: String) -> String {
        if md5String.isEmpty {
            return ""
        }
        let index = number % md5String.count
        let char = getCharByRandonNumber(number)
        var result = md5String
        let startIndex = result.index(result.startIndex, offsetBy: index)
        result.insert(contentsOf: char, at: startIndex)
        return result
    }

    
}
