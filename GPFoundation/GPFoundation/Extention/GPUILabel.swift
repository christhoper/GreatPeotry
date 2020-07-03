//
//  GPUILabel.swift
//  GPFoundation
//
//  Created by bailun on 2020/6/30.
//  Copyright © 2020 Baillun. All rights reserved.
//

import UIKit
import CommonCrypto

public extension UILabel {
    func defaultConfigure() {
        self.font = UIFont.AdaptiveRegularFont(size: 16)
        self.textColor = UIColor.gray102
    }
}


public extension Data {
    // MARK: cbc
    fileprivate func aesCBC(_ operation:CCOperation,key:String, iv:String? = nil) -> Data? {
        guard [16,24,32].contains(key.lengthOfBytes(using: String.Encoding.utf8)) else {
            return nil
        }
        let input_bytes = self.arrayOfBytes()
        let key_bytes = key.bytes
        var encrypt_length = Swift.max(input_bytes.count * 2, 16)
        var encrypt_bytes = [UInt8](repeating: 0,
                                    count: encrypt_length)
        
        let iv_bytes = (iv != nil) ? iv?.bytes : nil
        let status = CCCrypt(UInt32(operation),
                             UInt32(kCCAlgorithmAES128),
                             UInt32(kCCOptionPKCS7Padding),
                            key_bytes,
                            key.lengthOfBytes(using: String.Encoding.utf8),
                            iv_bytes,
                            input_bytes,
                            input_bytes.count,
                            &encrypt_bytes,
                            encrypt_bytes.count,
                            &encrypt_length)
        if status == Int32(kCCSuccess) {
            return Data(bytes: UnsafePointer<UInt8>(encrypt_bytes), count: encrypt_length)
        }
        return nil
    }
    /// Encrypt data in CBC Mode, iv will be filled with zero if not specificed
    func aesCBCEncrypt(_ key:String,iv:String? = nil) -> Data? {
        return aesCBC(UInt32(kCCEncrypt), key: key, iv: iv)
    }
    /// Decrypt data in CBC Mode ,iv will be filled with zero if not specificed
    func aesCBCDecrypt(_ key:String,iv:String? = nil)->Data?{
        return aesCBC(UInt32(kCCDecrypt), key: key, iv: iv)
    }
    // MARK: ecb
    fileprivate func aesEBC(_ operation:CCOperation, key:String) -> Data? {
        guard [16,24,32].contains(key.lengthOfBytes(using: String.Encoding.utf8)) else {
            return nil
        }
        let input_bytes = self.arrayOfBytes()
        let key_bytes = key.bytes
        var encrypt_length = Swift.max(input_bytes.count * 2, 16)
        var encrypt_bytes = [UInt8](repeating: 0,
                                    count: encrypt_length)
        let status = CCCrypt(UInt32(operation),
                             UInt32(kCCAlgorithmAES128),
                             UInt32(kCCOptionPKCS7Padding + kCCOptionECBMode),
                             key_bytes,
                             key.lengthOfBytes(using: String.Encoding.utf8),
                             nil,
                             input_bytes,
                             input_bytes.count,
                             &encrypt_bytes,
                             encrypt_bytes.count,
                             &encrypt_length)
        if status == Int32(kCCSuccess) {
            return Data(bytes: UnsafePointer<UInt8>(encrypt_bytes), count: encrypt_length)
        }
        return nil
    }
    /// Encrypt data in EBC Mode
    func aesEBCEncrypt(_ key:String) -> Data? {
        return aesEBC(UInt32(kCCEncrypt), key: key)
        
    }
    /// Decrypt data in EBC Mode
    func aesEBCDecrypt(_ key:String) -> Data? {
        return aesEBC(UInt32(kCCDecrypt), key: key)
    }
}


extension String {
    // MARK: cbc
    /// Encrypt string in CBC mode, iv will be filled with Zero if not specificed
    public func aesCBCEncrypt(_ key:String,iv:String? = nil) -> Data? {
        let data = self.data(using: String.Encoding.utf8)
//        print(data!.hexString)
        return data?.aesCBCEncrypt(key, iv: iv)
    }
    /// Decrypt a hexadecimal string in CBC Mode, iv will be filled with Zero if not specificed
    public func aesCBCDecryptFromHex(_ key:String,iv:String? = nil) ->String?{
        let data = self.dataFromHexadecimalString()
        guard let raw_data = data?.aesCBCDecrypt(key, iv: iv) else{
            return nil
        }
//        print(raw_data.hexString)
        return String(data: raw_data, encoding: String.Encoding.utf8)
    }
    /// Decrypt a base64 string in CBC mode, iv will be filled with Zero if not specificed
    public func aesCBCDecryptFromBase64(_ key:String, iv:String? = nil) ->String? {
        let data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions())
        guard let raw_data = data?.aesCBCDecrypt(key, iv: iv) else{
            return nil
        }
        return String(data: raw_data, encoding: String.Encoding.utf8)
    }
    // MARK: ebc
    /// Encrypt a string in EBC Mode
    public func aesEBCEncrypt(_ key:String) -> Data? {
        let data = self.data(using: String.Encoding.utf8)
        return data?.aesEBCEncrypt(key)
    }
    /// Decrypt a hexadecimal string in EBC Mode
    public func aesEBCDecryptFromHex(_ key:String) -> String? {
        let data = self.dataFromHexadecimalString()
        guard let raw_data = data?.aesEBCDecrypt(key) else {
            return nil
        }
        return String(data: raw_data, encoding: String.Encoding.utf8)
    }
    /// Decrypt a base64 string in EBC Mode
    public func aesEBCDecryptFromBase64(_ key:String) -> String? {
        let data = Data(base64Encoded: self, options: NSData.Base64DecodingOptions())
        guard let raw_data = data?.aesEBCDecrypt(key) else {
            return nil
        }
        return String(data: raw_data, encoding: String.Encoding.utf8)
    }
}





/**
 * Index
 */
extension Int {
    public subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
            for _ in 1...digitIndex {
                decimalBase *= 10
            }
        return (self / decimalBase) % 10
    }
}

extension UInt {
    public subscript(digitIndex: Int) -> UInt {
        var decimalBase:UInt = 1
            for _ in 1...digitIndex {
                decimalBase *= 10
            }
            return (self / decimalBase) % 10
    }
}

extension UInt8 {
    public subscript(digitIndex: Int) -> UInt8 {
        var decimalBase:UInt8 = 1
            for _ in 1...digitIndex {
                decimalBase *= 10
            }
            return (self / decimalBase) % 10
    }
}
extension Data {
    public func hexadecimalString() -> String {
        let string = NSMutableString(capacity: count * 2)
        var byte: UInt8 = 0
        for i in 0 ..< count {
            copyBytes(to: &byte, from: i..<index(after: i))
            string.appendFormat("%02x", byte)
        }
        
        return string as String
    }
    public var hexString : String {
        return self.hexadecimalString()
    }
    public var base64String:String {
        return self.base64EncodedString(options: NSData.Base64EncodingOptions())
    }
    /// Array of UInt8
    public func arrayOfBytes() -> [UInt8] {
        let count = self.count / MemoryLayout<UInt8>.size
        var bytesArray = [UInt8](repeating: 0, count: count)
        (self as NSData).getBytes(&bytesArray, length:count * MemoryLayout<UInt8>.size)
        return bytesArray
    }
}
extension String {
    /// Array of UInt8
    public var arrayOfBytes:[UInt8] {
        let data = self.data(using: String.Encoding.utf8)!
        return data.arrayOfBytes()
    }
    public var bytes:UnsafeRawPointer{
        let data = self.data(using: String.Encoding.utf8)!
        return (data as NSData).bytes
    }
    /// Get data from hexadecimal string
    func dataFromHexadecimalString() -> Data? {
        let trimmedString = self.trimmingCharacters(in: CharacterSet(charactersIn: "<> ")).replacingOccurrences(of: " ", with: "")
        
        // make sure the cleaned up string consists solely of hex digits, and that we have even number of them
        guard let regex = try? NSRegularExpression(pattern: "^[0-9a-f]*$", options: NSRegularExpression.Options.caseInsensitive) else{
            return nil
        }
        let trimmedStringLength = trimmedString.lengthOfBytes(using: String.Encoding.utf8)
        let found = regex.firstMatch(in: trimmedString, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSMakeRange(0, trimmedStringLength))
        if found == nil || found?.range.location == NSNotFound || trimmedStringLength % 2 != 0 {
            return nil
        }
        
        // everything ok, so now let's build NSData
        
//        let data = NSMutableData(capacity: trimmedStringLength / 2)
        
        var data = Data(capacity: trimmedStringLength / 2)
        
        for index in trimmedString.indices {
            let next_index = trimmedString.index(after: index)
            let byteString = trimmedString.substring(with: index ..< next_index)
            let num = UInt8(byteString.withCString { strtoul($0, nil, 16) })
//            data.append([num] as [UInt8], length: 1)
            data.append(num)
        }
        
//        return data as Data?
        return data
    }
}
