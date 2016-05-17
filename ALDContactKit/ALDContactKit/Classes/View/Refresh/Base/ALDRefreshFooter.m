//  代码地址: https://github.com/CoderMJLee/ALDRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
//  ALDRefreshFooter.m
//  ALDRefreshExample
//
//  Created by MJ Lee on 15/3/5.
//  Copyright (c) 2015年 小码哥. All rights reserved.
//

#import "ALDRefreshFooter.h"

@interface ALDRefreshFooter()

@end

@implementation ALDRefreshFooter
#pragma mark - 构造方法
+ (instancetype)footerWithRefreshingBlock:(ALDRefreshComponentRefreshingBlock)refreshingBlock
{
    ALDRefreshFooter *cmp = [[self alloc] init];
    cmp.refreshingBlock = refreshingBlock;
    return cmp;
}
+ (instancetype)footerWithRefreshingTarget:(id)target refreshingAction:(SEL)action
{
    ALDRefreshFooter *cmp = [[self alloc] init];
    [cmp setRefreshingTarget:target refreshingAction:action];
    return cmp;
}

#pragma mark - 重写父类的方法
- (void)prepare
{
    [super prepare];
    
    // 设置自己的高度
    self.mj_h = ALDRefreshFooterHeight;
}


- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
    if ([self.scrollView isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.scrollView;
        NSInteger count = 0;
        NSInteger sections = [tableView numberOfSections];
        for (NSInteger i = 0; i < sections; i++) {
            count += [tableView numberOfRowsInSection:i];
        }
        self.hidden = (count == 0);
    } else if ([self.scrollView isKindOfClass:[UICollectionView class]]) {
        UICollectionView *collectionView = (UICollectionView *)self.scrollView;
        NSInteger count = 0;
        NSInteger sections = [collectionView numberOfSections];
        for (NSInteger i = 0; i < sections; i++) {
            count += [collectionView numberOfItemsInSection:i];
        }
        self.hidden = (count == 0);
    }
}

#pragma mark - 公共方法
- (void)noticeNoMoreData
{
    self.state = ALDRefreshStateNoMoreData;
}

- (void)resetNoMoreData
{
    self.state = ALDRefreshStateIdle;
}
@end
