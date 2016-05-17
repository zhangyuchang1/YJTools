//
//  SearchDisplayViewController.m
//  ALDContactKit
//
//  Created by zyc on 15/8/17.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "SearchDisplayViewController.h"
#import "ALDSearchManager.h"

@interface SearchDisplayViewController()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property (nonatomic, strong) UITableView  *contactTableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, retain) UISearchDisplayController *searchDisplayVC;  //8.0之前


@property (nonatomic, strong) NSArray *dataSource;       //数据源

@property (nonatomic, strong) NSMutableArray *dataArray; //数据未分组
@property (nonatomic, strong) NSMutableArray *sortArray; //筛选结果

@end

@implementation SearchDisplayViewController
- (void) createViews {
    
    // 创建tableView
    self.contactTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    self.contactTableView.delegate = self;
    self.contactTableView.dataSource = self;
    [self.view addSubview:self.contactTableView];
    
    //搜索栏
    self.searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    self.searchBar.placeholder = @"搜索";
    self.searchBar.delegate = self;
    self.searchBar.tintColor = [UIColor yellowColor];
//    self.searchBar.barTintColor = RGB(200, 240, 240, 1);
//    self.searchBar.layer.borderColor = RGB(200, 240, 240, 1).CGColor;
    
    self.contactTableView.tableHeaderView = self.searchBar;

    //搜索展示 8.0之前
    self.searchDisplayVC = [[UISearchDisplayController alloc] initWithSearchBar:self.searchBar contentsController:self];
    self.searchDisplayVC.displaysSearchBarInNavigationBar = NO;
    self.searchDisplayVC.active = NO;
    self.searchDisplayVC.searchResultsDelegate = self;
    self.searchDisplayVC.searchResultsDataSource = self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = [NSMutableArray array];
    self.sortArray = [NSMutableArray array];
    
    self.dataSource = @[@{@"indexTitle": @"A",@"data":@[@"adam", @"肮脏", @"熬不过去", @"abdul", @"anastazja", @"angelica",@"阿狸",@"啊啊"]},@{@"indexTitle": @"D",@"data":@[@"dennis" , @"deamon", @"destiny", @"dragon", @"dry", @"大啊", @"drums",@"大帝",@"刀塔"]},@{@"indexTitle": @"F",@"data":@[@"Fredric", @"France", @"friends", @"family", @"fatish", @"funeral"]},@{@"indexTitle": @"M",@"data":@[@"Mark", @"Madeline"]},@{@"indexTitle": @"N",@"data":@[@"Nemesis", @"nemo", @"name"]},@{@"indexTitle": @"O",@"data":@[@"Obama", @"Oprah", @"Omen", @"OMG OMG OMG", @"O-Zone", @"Ontario"]},@{@"indexTitle": @"Z",@"data":@[@"Zeus",@"渣渣",@"张三", @"Zebra", @"zed"]}];
    
    for (NSDictionary *dic in self.dataSource) {
        
        NSArray *arr = dic[@"data"];
        
        [self.dataArray addObjectsFromArray:arr];
    }
    
    self.sortArray = [NSMutableArray arrayWithArray:self.dataArray];
    [self createViews];
}


#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    
    if (tableView == self.searchDisplayVC.searchResultsTableView) {
        return nil;
    }else{
        return self.dataSource[section][@"indexTitle"];
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (tableView == self.searchDisplayVC.searchResultsTableView) {
        return 1;
        
    }else{
        return self.dataSource.count;
        
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayVC.searchResultsTableView) {
        
        return self.sortArray.count;
    }else{
        return [self.dataSource[section][@"data"] count];
        
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString * cellName = @"UITableViewCell";
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    if (tableView == self.searchDisplayVC.searchResultsTableView) {
        
        id  text = self.sortArray[indexPath.row];
        if ([text isKindOfClass:[NSAttributedString class]]) {
            cell.textLabel.attributedText = text;
        }else{
            cell.textLabel.text = text;
        }
    
    }else{
        NSString *string = self.dataSource[indexPath.section][@"data"][indexPath.row];
        cell.textLabel.attributedText = [[NSAttributedString alloc] initWithString:string];
    }
    return cell;
}

#pragma mark - UIScrollViewDelegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    
//    [_searchBar resignFirstResponder];
//}

#pragma mark - UISearchDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
//    if (_searchBar.text.length == 0) {
//        
//    }else{
    
        [self filterContentForSearchText:_searchBar.text];
//        [self.contactTableView reloadData];

//    }
    
}

//源字符串内容是否包含或等于要搜索的字符串内容
-(void)filterContentForSearchText:(NSString*)searchText
{
    [self.sortArray removeAllObjects];
    
//************************** 模糊匹配 *************************
//    NSArray *array =  [ALDSearchManager filterFromArray:self.dataArray searchString:searchText highlightColor:[UIColor purpleColor]];
//************************** 精确包含匹配 *************************
    NSArray *array = [ALDSearchManager filterContentFromArray:self.dataArray searchString:searchText highlightColor:[UIColor purpleColor]];
    
    [self.sortArray addObjectsFromArray:array];
}

#pragma mark - UISearchDesplay Delegate
- (void) searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
}
@end
