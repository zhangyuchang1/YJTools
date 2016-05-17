//
//  ALDStringCheck.h
//  ALDContactKit
//
//  Created by zyc on 15/8/18.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDStringCheck : NSObject

//校验用户名
+ (BOOL)validateUserName:(NSString *)str;
//校验用户密码
+ (BOOL)validateUserPasswd:(NSString *)str;
//校验用户生日
+ (BOOL)validateUserBornDate:(NSString *)str;
//校验用户手机号码
+ (BOOL)validateUserPhone:(NSString *)str;
//校验用户邮箱
+ (BOOL)validateUserEmail:(NSString *)str;


@end
