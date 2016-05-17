//
//  ALDTableIndex.h
//  ALDContactKit
//
//  Created by zyc on 15/8/6.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ALDTableViewDelegate;
@interface ALDTableIndex : UIView
@property (nonatomic, strong) id<ALDTableViewDelegate> delegate;

/**
 *  初始化方法，加在View上 ，索引数据与 tableView绑定
 *
 *  @param view      索引要加在上的视图
 *  @param tableView 数据绑定的tableView
 *
 *  @return 索引视图
 */
- (id)initAddOnView:(UIView *)view bindTableView:(UITableView *)tableView;
/**
 *  设置索引的背景颜色，默认为淡绿色
 *
 *  @param color 颜色
 */
- (void)setBageColor:(UIColor *)color;
/**
 *  设置索引的字体颜色，默认为淡黑色
 *
 *  @param color 颜色
 */
- (void)setTextColor:(UIColor *)color;
/**
 *  设置索引的顶部图片，默认为放大镜图片
 *
 *  @param image 图像
 */
- (void)setHeaderImage:(UIImage *)image;
/**
 *  隐藏放大镜视图，默认显示
 */
- (void)setHiddenHeaderImage;

@end

@protocol ALDTableViewDelegate <UITableViewDataSource,UITableViewDelegate>

/**
 *  触摸了索引顶部放大镜视图
 */
- (void)searchButtonTouched;
/**
 *  索引的数据数组
 *
 *  @param tableIndex 索引
 *
 *  @return 索引的数据数组
 */
- (NSArray *)sectionIndexTitlesForALDTableView:(ALDTableIndex *)tableIndex;


@end