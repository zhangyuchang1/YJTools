//
//  ALDRefreshBackStateFooter.h
//  ALDRefreshExample
//
//  Created by MJ Lee on 15/6/13.
//  Copyright © 2015年 小码哥. All rights reserved.
//

#import "ALDRefreshBackFooter.h"

@interface ALDRefreshBackStateFooter : ALDRefreshBackFooter
/** 显示刷新状态的label */
@property (weak, nonatomic, readonly) UILabel *stateLabel;
/** 设置state状态下的文字 */
- (void)setTitle:(NSString *)title forState:(ALDRefreshState)state;
@end
