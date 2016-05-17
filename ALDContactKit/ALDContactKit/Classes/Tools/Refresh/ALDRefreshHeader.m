//
//  ALDRefreshHeader.m
//  ALDContactKit
//
//  Created by zyc on 15/8/11.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "ALDRefreshHeader.h"

@implementation ALDRefreshHeader

#pragma mark - 重写方法
#pragma mark 基本设置
- (void)prepare
{

    [super prepare];
    
    self.automaticallyChangeAlpha = YES;
    //隐藏时间label
//    self.lastUpdatedTimeLabel.hidden = YES;
    
    // 设置普通状态的动画图片
    NSMutableArray *idleImages = [NSMutableArray array];
//    for (NSUInteger i = 1; i<=60; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"aldFish_1"]];
        [idleImages addObject:image];
//    }
    [self setImages:idleImages forState:MJRefreshStateIdle];
    
    // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
    NSMutableArray *refreshingImages = [NSMutableArray array];
    for (NSUInteger i = 1; i<=3; i++) {
        UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"aldFish_%zd", i]];
        [refreshingImages addObject:image];
    }
    [self setImages:idleImages forState:MJRefreshStatePulling];
    
    // 设置正在刷新状态的动画图片
    [self setImages:refreshingImages duration:0.6 forState:MJRefreshStateRefreshing ];
}

#pragma mark 重置子视图布局
- (void)placeSubviews
{
    [super placeSubviews];
    
    self.mj_h = ALDRefreshHeaderHeight;
    self.mj_y = - self.mj_h - self.ignoredScrollViewContentInsetTop;
//    self.backgroundColor = [UIColor blueColor];
    
    //图片
    self.gifView.mj_x = 0;
    self.gifView.mj_y = 0;
    self.gifView.mj_w = self.mj_w;
    self.gifView.mj_h = self.mj_h/2.0;
    self.gifView.contentMode = UIViewContentModeCenter;
//    self.gifView.backgroundColor = [UIColor purpleColor];
    
    //状态label
    self.stateLabel.mj_y = self.mj_h-self.gifView.mj_h;
    self.stateLabel.mj_h = 27;
//    self.stateLabel.backgroundColor = [UIColor greenColor];


    //时间label
    self.lastUpdatedTimeLabel.mj_y = self.mj_h-27;
    self.lastUpdatedTimeLabel.mj_h = 27;
//    self.lastUpdatedTimeLabel.backgroundColor = [UIColor redColor];

}

@end
