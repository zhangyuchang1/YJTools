//
//  ALDSearchManager.h
//  ALDContactKit
//
//  Created by zyc on 15/8/17.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDSearchManager : NSObject
/**
 *  输入字符串，对数组查询，支持拼音，拼音首字母，拼音中间字母进行搜索
 *
 *  @param array  原数组
 *  @param string 筛选字符串
 *  @param color  高亮颜色，返回带颜色的AttributedString的数组，当color为nil，返回string数组
 *
 *  @return 筛选结果数组
 */
+(NSArray *)filterFromArray:(NSArray *)array searchString:(NSString *)string highlightColor:(UIColor *)color;
/**
 *  输入字符串，对数组查询,仅匹配是否包含
 *
 *  @param array  原数组
 *  @param string 筛选字符串
 *  @param color  高亮颜色，返回带颜色的AttributedString的数组，当color为nil，返回string数组
 *
 *  @return 筛选结果数组
 */
+(NSArray *)filterContentFromArray:(NSArray *)array searchString:(NSString *)string highlightColor:(UIColor *)color;
@end
