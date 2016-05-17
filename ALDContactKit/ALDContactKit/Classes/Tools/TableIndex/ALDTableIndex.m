//
//  ALDTableIndex.m
//  ALDContactKit
//
//  Created by zyc on 15/8/6.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "ALDTableIndex.h"
#import "ALDTableViewIndex.h"


@interface ALDTableIndex()<ALDTableViewIndexDelegate>
@property (nonatomic, strong) UITableView * tableView;

@property (nonatomic, strong) UILabel * flotageLabel;
@property (nonatomic, strong) ALDTableViewIndex * tableViewIndex;

@property (nonatomic, strong) UIView  *fatherView;   // 加索引视图 的父视图
@property (nonatomic, strong) UITableView *bindTableView;  //索引绑定的表视图


@end

@implementation ALDTableIndex

- (id)initAddOnView:(UIView *)view bindTableView:(UITableView *)tableView
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        // Initialization code
        
        self.fatherView = view;
        self.bindTableView = tableView;
        
        self.tableView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        self.tableView.backgroundColor = [UIColor redColor];
        self.tableView.hidden = YES;
        
        self.tableView.showsVerticalScrollIndicator = NO;
        [self addSubview:self.tableView];
        
        self.tableViewIndex = [[ALDTableViewIndex alloc] initWithFrame:(CGRect){view.bounds.size.width-20,100,20,view.frame.size.height +20}];
        
        //        [self addSubview:self.tableViewIndex];
        [view addSubview:self.tableViewIndex];
        
        self.tableViewIndex.tableViewIndexDelegate = self;
        
        self.flotageLabel = [[UILabel alloc] initWithFrame:(CGRect){(view.bounds.size.width - 90 ) / 2,(view.bounds.size.height - 90) / 2,90,90}];
        
        self.flotageLabel.backgroundColor = K_COLOR_LIGHTGREEN;
        self.flotageLabel.alpha = 0;
        //        self.flotageLabel.hidden = YES;
        self.flotageLabel.textAlignment = NSTextAlignmentCenter;
        self.flotageLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:50];
        self.flotageLabel.textColor = [UIColor whiteColor];
        self.flotageLabel.layer.cornerRadius = 45;
        self.flotageLabel.layer.masksToBounds = YES;
        
        //        [self.superview addSubview:self.flotageLabel];
        
        [view addSubview:self.flotageLabel];
        [view addSubview:self];
    }
    return self;
}

#pragma mark - 自定义接口
- (void)setBageColor:(UIColor *)color
{
    self.tableViewIndex.bageColor = color;
    self.flotageLabel.backgroundColor = color;
}

- (void)setTextColor:(UIColor *)color
{
    self.tableViewIndex.textColor = color;
}

- (void)setHeaderImage:(UIImage *)image
{
    self.tableViewIndex.headerImage = image;
}

- (void)setHiddenHeaderImage
{
    self.tableViewIndex.isHiddenHeaderImage = YES;
}


- (void)setDelegate:(id<ALDTableViewDelegate>)delegate
{
    _delegate = delegate;
//    self.tableView.delegate = delegate;
//    self.tableView.dataSource = delegate;
    self.tableViewIndex.indexes = [self.delegate sectionIndexTitlesForALDTableView:self];
    CGRect rect = self.tableViewIndex.frame;
    rect.size.height = self.tableViewIndex.indexes.count * 16 +20;
//    rect.origin.y = (self.fatherView.bounds.size.height - rect.size.height) / 2  - 10;
    rect.origin.y = (self.fatherView.bounds.size.height - rect.size.height) / 2 ;

    self.tableViewIndex.frame = rect;
    
    self.tableViewIndex.tableViewIndexDelegate = self;
}

- (void)reloadData
{
//        [self.tableView reloadData];
//    
//        UIEdgeInsets edgeInsets = self.tableView.contentInset;
//    
//        self.tableViewIndex.indexes = [self.delegate sectionIndexTitlesForALDTableView:self];
//        CGRect rect = self.tableViewIndex.frame;
//        rect.size.height = self.tableViewIndex.indexes.count * 16;
//        rect.origin.y = (self.bounds.size.height - rect.size.height - edgeInsets.top - edgeInsets.bottom) / 2 + edgeInsets.top + 20;
//    //    self.tableViewIndex.frame = rect;
//        self.tableViewIndex.tableViewIndexDelegate = self;
}


#pragma mark - BATableViewIndex Delegate
- (void)tableViewIndex:(ALDTableViewIndex *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title
{
    if ([self.bindTableView numberOfSections] > index && index > -1){   // for safety, should always be YES
        [self.bindTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index]
                                  atScrollPosition:UITableViewScrollPositionTop
                                          animated:NO];
        self.flotageLabel.text = title;
    }
}

- (void)tableViewIndexTouchesBegan:(ALDTableViewIndex *)tableViewIndex
{
    self.flotageLabel.alpha = 0.5;
}

- (void)tableViewIndexTouchesEnd:(ALDTableViewIndex *)tableViewIndex
{
    [UIView beginAnimations:@"alpha" context:nil];
    [UIView setAnimationDuration:0.4];
    self.flotageLabel.alpha=0;
    [UIView commitAnimations];
    //    [self.flotageLabel.layer addAnimation:animation forKey:nil];
    //
    //    self.flotageLabel.hidden = YES;
}

- (NSArray *)tableViewIndexTitle:(ALDTableViewIndex *)tableViewIndex
{
    return [self.delegate sectionIndexTitlesForALDTableView:self];
}
- (void)searchButtonTouched
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(searchButtonTouched)]) {
        [self.delegate searchButtonTouched];
    }
}
@end
