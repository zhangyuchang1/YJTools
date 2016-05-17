//
//  ALDGroupAvatar.h
//  ALDContactKit
//
//  Created by zyc on 15/8/11.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ALDGroupAvatarView : UIView


//@property (nonatomic,retain)  UIImage *backgroudImage;
@property (nonatomic, assign) float HeaderHeight;


/**
 *  设置 暂位 图片，不设时没有暂位图，未加载完的内部图片为淡灰色背景图像
 *
 *  @param image 图像
 */
-(void)setDefaultImage:(UIImage *)image;
/**
 *  由uids 布局内部图像，用ALDImage缓存 异步加载
 *
 *  @param uids uid数组
 */
-(void)setUpaAsyncWithImageURLs:(NSArray *)imageURLs;
/**
 *  由一组图像 布局内部图像
 *
 *  @param images 图像数组
 */
-(void)setUpWithImages:(NSArray *)images;
/**
 *  由一组图像url地址的 字符串，布局内部图像，同步加载
 *
 *  @param imageURLs url字符串 数组
 */
//-(void)setUpSyncWithImageURLs:(NSArray *)imageURLs;


@end
