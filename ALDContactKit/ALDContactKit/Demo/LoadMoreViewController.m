//
//  LoadMoreViewController.m
//  ALDContactKit
//
//  Created by zyc on 15/8/10.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "LoadMoreViewController.h"
#import "ALDRefresh.h"

#define RANDOM_STRING [NSString stringWithFormat:@"%d", arc4random_uniform(1000000)]
#define RANDOM_COLOR  RGB((arc4random()%255), (arc4random()%255), (arc4random()%255), 1)

@interface LoadMoreViewController ()
/** 用来显示的假数据 */
@property (strong, nonatomic) NSMutableArray *data;
@end

@implementation LoadMoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 60.0;

//************************ 一般样式 *************************//
    
//    __weak __typeof(self) weakSelf = self;
//
////     设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    self.tableView.footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
//        [weakSelf loadMoreData];
//    }];
    
//************************ 阿拉丁样式 *************************//
    
    __weak __typeof(self) weakSelf = self;
    
    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
    self.tableView.footer = [ALDRefreshFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 上拉加载更多数据
- (void)loadMoreData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data addObject:RANDOM_STRING];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的上拉刷新控件，结束刷新状态
        [self.tableView.footer endRefreshing];
    });
}
- (NSMutableArray *)data
{
    if (!_data) {
        self.data = [NSMutableArray array];
        for (int i = 0; i<5; i++) {
            [self.data addObject:RANDOM_STRING];
        }
    }
    return _data;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    
    NSString *dataString = self.data[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"随机数据--%@", self.data[indexPath.row]];
    
    [cell.imageView setImage:[UIImage imageNamed:@"clearImage"]];
    
  UIColor *cellColor =  RGB(([dataString intValue]%255)*1.1, ([dataString intValue]%255)*0.2, ([dataString intValue]%255)*0.6, 1);
    [cell.imageView setBackgroundColor:cellColor];

    
    return cell;
}

@end
