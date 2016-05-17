//
//  ALDPhoneContacts.h
//  ALDContactKit
//
//  Created by zyc on 15/8/12.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <Foundation/Foundation.h>
#define ALDMOBILE_NUMBER @"ALDMOBILE_NUMBER"   //手机通讯录中的 手机号
#define ALDMOBILE_NAME   @"ALDMOBILE_NAME"     //手机通讯录中的 姓名

//不同的结果
#define ADDRESS_TPYE_SUECESS        @"获取成功"
#define ADDRESS_TPYE_REJECT         @"授权限制，获取失败"
#define ADDRESS_TPYE_HINT_SUECESS   @"允许了访问，获取成功"
#define ADDRESS_TPYE_HINT_REJECT    @"拒绝了访问，获取失败"


@interface ALDPhoneContacts : NSObject

/**
 *  获取设备上的通讯录 姓名和手机号
 *
 *  @param block 返回成功或失败的信息和 通讯录结果
 */
+(void)addressBookIdentification:(void(^)(NSString *info, NSMutableArray *contacts))block;

@end
