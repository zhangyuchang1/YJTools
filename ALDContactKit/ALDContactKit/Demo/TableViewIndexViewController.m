//
//  TableViewIndexViewController.m
//  ALDContactKit
//
//  Created by zyc on 15/8/6.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "TableViewIndexViewController.h"

#import "ALDTableIndex.h"

@interface TableViewIndexViewController ()<ALDTableViewDelegate,UITableViewDelegate,UITableViewDataSource>
//@property (nonatomic, strong) ALDTableIndex *contactTableView;

@property (nonatomic, strong) UITableView  *contactTableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, strong) NSArray * dataSource;

@end
@implementation TableViewIndexViewController

- (void) createTableView {
    
    // 创建tableView
    self.contactTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.contactTableView.delegate = self;
    self.contactTableView.dataSource = self;
    [self.view addSubview:self.contactTableView];
    
    //搜索栏
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    self.contactTableView.tableHeaderView = self.searchBar;
    
//**************************** 默认样式 ****************************
    ALDTableIndex *tableIndex = [[ALDTableIndex alloc] initAddOnView:self.view bindTableView:self.contactTableView];
    tableIndex.delegate = self;
    
//**************************** 自定义样式，不加为默认样式 ****************************
    
//    [tableIndex setBageColor:[UIColor redColor]];
//    [tableIndex setTextColor:[UIColor purpleColor]];
//    [tableIndex setHiddenHeaderImage];
    
    [tableIndex setHeaderImage:[UIImage imageNamed:@"crossImage"]];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = @[@{@"indexTitle": @"A",@"data":@[@"adam", @"alfred", @"ain", @"abdul", @"anastazja", @"angelica"]},@{@"indexTitle": @"D",@"data":@[@"dennis" , @"deamon", @"destiny", @"dragon", @"dry", @"debug", @"drums"]},@{@"indexTitle": @"F",@"data":@[@"Fredric", @"France", @"friends", @"family", @"fatish", @"funeral"]},@{@"indexTitle": @"M",@"data":@[@"Mark", @"Madeline"]},@{@"indexTitle": @"N",@"data":@[@"Nemesis", @"nemo", @"name"]},@{@"indexTitle": @"O",@"data":@[@"Obama", @"Oprah", @"Omen", @"OMG OMG OMG", @"O-Zone", @"Ontario"]},@{@"indexTitle": @"Z",@"data":@[@"Zeus", @"Zebra", @"zed"]}];
    [self createTableView];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - ALDTableViewDelegate
//- (NSArray *) sectionIndexTitlesForADLTableView:(ALDTableIndex *)tableView {
- (NSArray *)sectionIndexTitlesForALDTableView:(ALDTableIndex *)tableIndex{

    NSMutableArray * indexTitles = [NSMutableArray array];
    for (NSDictionary * sectionDictionary in self.dataSource) {
        [indexTitles addObject:sectionDictionary[@"indexTitle"]];
    }
    return indexTitles;
}

- (void)searchButtonTouched
{
    [self.contactTableView setContentOffset:CGPointMake(0, -64)];
   [self.searchBar becomeFirstResponder];
}

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.dataSource[section][@"indexTitle"];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.dataSource[section][@"data"] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    cell.textLabel.text = self.dataSource[indexPath.section][@"data"][indexPath.row];
    return cell;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.searchBar resignFirstResponder];
}



@end
