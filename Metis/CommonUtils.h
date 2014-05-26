//
//  CommonUtils.h
//  Metis
//
//  Created by ligang5 on 14-5-27.
//  Copyright (c) 2014年 ligang5. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>

@interface CommonUtils : NSObject

//传入参数格式: value,key,value,key...
+(NSMutableDictionary*)packParamsInDictionary:(id) params,...;

//验证邮箱格式是不是正确
+(BOOL)isEmailValid:(NSString*) email;

//生成随机字符串，包括数字和大小写的字母
+(NSString*)randomStringWithLength:(int)length;

//对str字符串进行md5加密
+(NSMutableString*)MD5EncryptionWithString:(NSString*)str;

//生成简单alertView
+(void)showSimpleAlertViewWithTitle:(NSString*)title WithMessage:(NSString*)message WithDelegate:(id)delegate WithCancelTitle:(NSString*)cancelTitle;

@end
