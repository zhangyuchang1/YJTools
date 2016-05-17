//
//  ALDPinYinForObjc.h
//  ALDContactKit
//
//  Created by zyc on 15/8/17.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDPinYinForObjc : NSObject

/**
 *  中文转换为拼音
 *
 *  @param chinese 中文字符串
 *
 *  @return  拼音字符串
 */
+ (NSString*)chineseConvertToPinYin:(NSString*)chinese;
/**
 *  中文转换为拼音首字母
 *
 *  @param chinese 中文字符串
 *
 *  @return  拼音首字母
 */
+ (NSString*)chineseConvertToPinYinHead:(NSString *)chinese;
@end
