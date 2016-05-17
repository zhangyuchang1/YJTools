//
//  ALDRadarItem.h
//  ALDContactKit
//
//  Created by zyc on 15/8/19.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^RadarTouchCompletion)(NSObject * user);


@interface ALDRadarItem : UIView


//@class EIMUser;


@property (nonatomic,retain) NSObject* user;

@property (nonatomic,assign) int x;
@property (nonatomic,assign) int y;

@property (nonatomic,copy) RadarTouchCompletion radarTouchCompletion;

- (instancetype)initWithX:(int)x andY:(int)y;

@end
