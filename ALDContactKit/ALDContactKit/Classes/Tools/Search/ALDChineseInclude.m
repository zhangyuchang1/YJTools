//
//  ALDChineseInclude.m
//  ALDContactKit
//
//  Created by zyc on 15/8/17.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "ALDChineseInclude.h"

@implementation ALDChineseInclude

+ (BOOL)isIncludeChineseInString:(NSString*)str {
    for (int i=0; i<str.length; i++) {
        unichar ch = [str characterAtIndex:i];
        if (0x4e00 < ch  && ch < 0x9fff) {
            return true;
        }
    }
    return false;
}
@end
