//
//  SearchTypeSelectController.m
//  ALDContactKit
//
//  Created by zyc on 15/8/14.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "SearchTypeSelectController.h"
#import "SearchBarViewController.h"
#import "SearchDisplayViewController.h"
#import "SearchViewController.h"

@interface SearchTypeSelectController ()

@property (nonatomic,retain) NSArray *types;

@end
@implementation SearchTypeSelectController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.types = @[@"搜索栏-SearchBar",@"搜索控制器-SearchDisplayController",@"搜索控制器SearchController"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    
    cell.textLabel.text = self.types[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
       [self.navigationController pushViewController:[[SearchBarViewController alloc] init] animated:YES];
    }
    if (indexPath.row == 1) {
        [self.navigationController pushViewController:[[SearchDisplayViewController alloc] init] animated:YES];
    }
    if (indexPath.row == 2) {
        [self.navigationController pushViewController:[[SearchDisplayViewController alloc] init] animated:YES];
    }
    
}
@end
