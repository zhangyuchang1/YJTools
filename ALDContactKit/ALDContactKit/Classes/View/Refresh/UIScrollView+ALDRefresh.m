//  代码地址: https://github.com/CoderMJLee/ALDRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  UIScrollView+ALDRefresh.m
//  ALDRefreshExample
//
//  Created by MJ Lee on 15/3/4.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "UIScrollView+ALDRefresh.h"
#import "ALDRefreshHeader.h"
#import "ALDRefreshFooter.h"
#import <objc/runtime.h>

@implementation UIScrollView (ALDRefresh)

#pragma mark - header
static const char ALDRefreshHeaderKey = '\0';
- (void)setHeader:(ALDRefreshHeader *)header
{
    if (header != self.header) {
        // 删除旧的，添加新的
        [self.header removeFromSuperview];
        [self addSubview:header];
        
        // 存储新的
        [self willChangeValueForKey:@"header"]; // KVO
        objc_setAssociatedObject(self, &ALDRefreshHeaderKey,
                                 header, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"header"]; // KVO
    }
}

- (ALDRefreshHeader *)header
{
    return objc_getAssociatedObject(self, &ALDRefreshHeaderKey);
}

#pragma mark - footer
static const char ALDRefreshFooterKey = '\0';
- (void)setFooter:(ALDRefreshFooter *)footer
{
    if (footer != self.footer) {
        // 删除旧的，添加新的
        [self.footer removeFromSuperview];
        [self addSubview:footer];
        
        // 存储新的
        [self willChangeValueForKey:@"footer"]; // KVO
        objc_setAssociatedObject(self, &ALDRefreshFooterKey,
                                 footer, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"footer"]; // KVO
    }
}

- (ALDRefreshFooter *)footer
{
    return objc_getAssociatedObject(self, &ALDRefreshFooterKey);
}
@end
