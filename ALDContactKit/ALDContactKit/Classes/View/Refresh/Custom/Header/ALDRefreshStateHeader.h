//
//  ALDRefreshStateHeader.h
//  ALDRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ALDRefreshHeader.h"

@interface ALDRefreshStateHeader : ALDRefreshHeader
#pragma mark - 刷新时间相关
/** 利用这个block来决定显示的更新时间文字 */
@property (copy, nonatomic) NSString *(^lastUpdatedTimeText)(NSDate *lastUpdatedTime);
/** 显示上一次刷新时间的label */
@property (weak, nonatomic, readonly) UILabel *lastUpdatedTimeLabel;

#pragma mark - 状态相关
/** 显示刷新状态的label */
@property (weak, nonatomic, readonly) UILabel *stateLabel;
/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(ALDRefreshState)state;
@end
