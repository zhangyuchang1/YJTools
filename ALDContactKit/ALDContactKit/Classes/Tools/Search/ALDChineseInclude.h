//
//  ALDChineseInclude.h
//  ALDContactKit
//
//  Created by zyc on 15/8/17.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDChineseInclude : NSObject
/**
 *  字符串是否含有中文
 *
 *  @param str 字符串
 *
 *  @return 是或否
 */
+ (BOOL)isIncludeChineseInString:(NSString*)str;

@end
