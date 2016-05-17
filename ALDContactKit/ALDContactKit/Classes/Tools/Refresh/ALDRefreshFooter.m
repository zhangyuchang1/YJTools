//
//  ALDRefreshFooter.m
//  ALDContactKit
//
//  Created by zyc on 15/8/11.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "ALDRefreshFooter.h"

@implementation ALDRefreshFooter

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{
    [super prepare];

    self.refreshingTitleHidden = YES;
    
    // 设置正在刷新状态的动画图片
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:refreshingImages forState:MJRefreshStateRefreshing];
}

@end
