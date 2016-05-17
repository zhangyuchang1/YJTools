//
//  ALDPinYinForObjc.m
//  ALDContactKit
//
//  Created by zyc on 15/8/17.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "ALDPinYinForObjc.h"
#import "PinYinForObjc.h"

@implementation ALDPinYinForObjc

+ (NSString*)chineseConvertToPinYin:(NSString*)chinese
{
    NSString *resultStr = [PinYinForObjc chineseConvertToPinYin:chinese];
    return resultStr;
}
+ (NSString*)chineseConvertToPinYinHead:(NSString *)chinese
{
    NSString *resultStr = [PinYinForObjc chineseConvertToPinYinHead:chinese];
    return resultStr;
}

@end
