//
//  ALDRefreshAutoFooter.h
//  ALDRefreshExample
//
//  Created by MJ Lee on 15/4/24.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ALDRefreshFooter.h"

@interface ALDRefreshAutoFooter : ALDRefreshFooter
/** 是否自动刷新(默认为YES) */
@property (assign, nonatomic, getter=isAutomaticallyRefresh) BOOL automaticallyRefresh;

/** 当底部控件出现多少时就自动刷新(默认为1.0，也就是底部控件完全出现时，才会自动刷新) */
@property (assign, nonatomic) CGFloat appearencePercentTriggerAutoRefresh;

/** 防止加载数据速度过快时，连续刷新N次 */
@property (assign, nonatomic, getter=isPreventContinuousRefreshing) BOOL preventContinuousRefreshing;
@end
