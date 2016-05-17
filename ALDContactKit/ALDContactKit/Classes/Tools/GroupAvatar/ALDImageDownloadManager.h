//
//  ALDImageDownloadManager.h
//  ALDContactKit
//
//  Created by zyc on 15/8/20.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <Foundation/Foundation.h>

//图片缓存管理器
@interface ALDImageDownloadManager : NSObject

/**
 *初始化（单实例）
 *@return 单实例
 */
+ (ALDImageDownloadManager *)sharedManager;

/**
 *根据图片名称和生成下载url
 *@param name 地图名称
 *@return 下载url
 */
- (NSURL *)urlWithName:(NSString *)name;

/**
 *根据图片获取下载绝对路径
 *@param name 地图瓦片名称
 *@return 瓦块保存绝对路径
 */
- (NSString *)getFilePath:(NSString *)name;

@end
