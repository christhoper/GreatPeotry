//
//  NSData+Encrypt.h
//  EZB
//
//  Created by Mr.Li  on 2018/5/3.
//  Copyright © 2018年 Mr.Li. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Encrypt)

/**
 *  利用AES加密数据
 *
 *  @param key key
 *  @param iv  iv description
 *
 *  @return data
 */
- (NSData *)encryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  @brief  利用AES解密数据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData *)decryptedWithAESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  利用3DES加密数据
 *
 *  @param key key
 *  @param iv  iv description
 *
 *  @return data
 */
- (NSData *)encryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;
/**
 *  @brief   利用3DES解密数据
 *
 *  @param key key
 *  @param iv  iv
 *
 *  @return 解密后数据
 */
- (NSData *)decryptedWith3DESUsingKey:(NSString*)key andIV:(NSData*)iv;

/**
 *  @brief  NSData 转成UTF8 字符串
 *
 *  @return 转成UTF8 字符串
 */
- (NSString *)UTF8String;


/**********************RSA加解密*************************************/

/**
 RSA 加密公钥
 
 @param pubKey 公钥
 @return raw data
 */
- (NSData *)encryptWithRSAUsingPublicKey:(NSString *)pubKey;

/**
 RSA 加密私钥
 
 @param privKey 私钥
 @return raw data
 */
- (NSData *)encryptWithRSAUsingPrivateKey:(NSString *)privKey;

/**
 RSA 解密公钥
 
 @param pubKey 公钥
 @return raw data
 */
- (NSData *)decryptWithRSAUsingPublicKey:(NSString *)pubKey;


/**
 RSA 解密私钥
 
 @param privKey 私钥
 @return raw data
 */
- (NSData *)decryptWithRSAUsingPrivateKey:(NSString *)privKey;

/**********************AES128加解密*************************************/

/**
 *  加密
 *
 *  @param key 公钥
 *  @param iv  偏移量
 *
 *  @return 加密之后的NSData
 */
- (NSData *)AES128EncryptWithKey:(NSString *)key iv:(NSString *)iv;
/**
 *  解密
 *
 *  @param key 公钥
 *  @param iv  偏移量
 *
 *  @return 解密之后的NSData
 */
- (NSData *)AES128DecryptWithKey:(NSString *)key iv:(NSString *)iv;

@end
