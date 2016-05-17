//
//  RefreshViewController.m
//  ALDContactKit
//
//  Created by zyc on 15/8/10.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "RefreshViewController.h"
#import "ALDRefresh.h"

#define RANDOM_STRING [NSString stringWithFormat:@"随机数据---%d", arc4random_uniform(1000000)]
#define RANDOM_COLOR  RGB((arc4random()%255), (arc4random()%255), (arc4random()%255), 1)
@interface RefreshViewController ()
@property (strong, nonatomic) NSMutableArray *data;

@end

@implementation RefreshViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView.rowHeight = 60.0;
 
//************************ 一般样式 *************************//
//    __weak __typeof(self) weakSelf = self;
//    
//    // 设置回调（一旦进入刷新状态就会调用这个refreshingBlock）
//    self.tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
//        [weakSelf loadNewData];
//    }];
//
    
//************************ 阿拉丁样式 *************************//
    __weak __typeof(self) weakSelf = self;

    self.tableView.header = [ALDRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadNewData];

    }];

    // 马上进入刷新状态
////    [self.tableView.header beginRefreshing];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark 下拉刷新数据
- (void)loadNewData
{
    // 1.添加假数据
    for (int i = 0; i<5; i++) {
        [self.data insertObject:RANDOM_STRING atIndex:0];
    }
    
    // 2.模拟2秒后刷新表格UI（真实开发中，可以移除这段gcd代码）
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 刷新表格
        [self.tableView reloadData];
        
        // 拿到当前的下拉刷新控件，结束刷新状态
        [self.tableView.header endRefreshing];
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
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.data[indexPath.row]];
    
    [cell.imageView setImage:[UIImage imageNamed:@"clearImage"]];
    [cell.imageView setBackgroundColor:RANDOM_COLOR];
    
    return cell;
}
@end
