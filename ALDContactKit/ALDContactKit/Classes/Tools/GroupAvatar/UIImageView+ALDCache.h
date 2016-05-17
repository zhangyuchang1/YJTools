//
//  UIImageView+ALDCache.h
//  ALDContactKit
//
//  Created by zyc on 15/8/20.
//  Copyright (c) 2015年 zyc. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIImageView (ALDCache)

/**
 *  异步缓存加载图片
 *
 *  @param url            图片url
 *  @param placeholde     站位图
 *  @param completedBlock 回调
 */
- (void)imageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholde  completed:(void(^)(NSString *info,UIImage *image))completedBlock;
@end
