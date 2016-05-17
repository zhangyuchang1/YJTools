//
//  RootViewController.m
//  ALDContacteKit
//
//  Created by apple on 15/7/30.
//  Copyright (c) 2015年 aladdin. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()
{
    NSArray*	_demoNameArray;
    NSArray*	_viewControllerArray;
    NSArray*	_viewControllerTitleArray;
}
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _demoNameArray = [[NSArray alloc]initWithObjects:
                      @"表视图索引功能-TableViewIndexDemo",
                      @"下拉刷新功能-TableViewRefreshDemo",
                      @"上拉加载更多功能-TableViewLoadMoreDemo",
                      @"群组头像功能-GroupAvatarViewDemo",
                      @"获取手机通讯录功能-PhoneContactsDemo",
                      @"搜索功能-SearchDemo",
//                      @"注册校验功能-CheckDemo",
                      @"雷达功能-RadarDemo",


                      nil];
    _viewControllerTitleArray = [[NSArray alloc]initWithObjects:
                                 @"表视图索引功能",
                                 @"下拉刷新功能",
                                 @"上拉加载更多功能",
                                 @"群组头像功能",
                                 @"获取手机通讯录功能",
                                 @"搜索功能",
//                                 @"注册校验",
                                 @"雷达功能",

                                 
                                 nil];
    
    _viewControllerArray = [[NSArray alloc]initWithObjects:
                            @"TableViewIndexViewController",
                            @"RefreshViewController",
                            @"LoadMoreViewController",
                            @"GroupAvatarViewController",
                            @"PhoneContactsViewController",
                            @"SearchTypeSelectController",
//                            @"CkeckViewController",
                            @"RadarViewController",
                            
                            nil];
    self.title = [NSString stringWithFormat: @"YJTools 常用工具集合"];
    //适配ios7
//    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
//    {
//        self.navigationController.navigationBar.translucent = NO;
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _demoNameArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ALDContactKitCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [_demoNameArray objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    UIViewController* viewController = [[NSClassFromString([_viewControllerArray objectAtIndex:indexPath.row]) alloc] init];
    viewController.title = [_viewControllerTitleArray objectAtIndex:indexPath.row];
    UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] init] ;
    customLeftBarButtonItem.title = @"返回";
//    viewController.navigationItem.leftBarButtonItem = customLeftBarButtonItem;
    self.navigationItem.backBarButtonItem = customLeftBarButtonItem;
    
    
    [self.navigationController pushViewController:viewController animated:YES];
    
//    UIViewController *view = [[UIViewController alloc] init];
//    
//    [self.navigationController pushViewController:view animated:YES];
    
    
}
@end
