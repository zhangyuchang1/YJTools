//
//  ABELTableViewIndex.h
//  ABELTableViewDemo
//
//  Created by abel on 14-4-28.
//  Copyright (c) 2014年 abel. All rights reserved.
//

#import <UIKit/UIKit.h>

//默认索引背景淡绿
#define K_COLOR_LIGHTGREEN [UIColor colorWithRed:99.0/255 green:196.0/255 blue:93.0/255 alpha:1]
//默认索引字体淡黑色
#define K_COLOR_LIGHTBLACK [UIColor colorWithRed:50.0/255 green:50.0/255 blue:50.0/255 alpha:1]


@protocol ALDTableViewIndexDelegate;

@interface ALDTableViewIndex : UIView
@property (nonatomic, strong) NSArray *indexes;
@property (nonatomic, strong) UIImageView *magnifyView;    //索引最上面 加的 放大镜

@property (nonatomic, weak) id <ALDTableViewIndexDelegate> tableViewIndexDelegate;


@property (nonatomic, strong) UIImage *headerImage;    //索引最上面 加的 自定义图片，默认位放大镜
@property (nonatomic, strong) UIColor *bageColor;      //索引背静颜色  默认位为淡绿色
@property (nonatomic, strong) UIColor *textColor;      //索引字体颜色，默认黑色

@property (nonatomic, assign) BOOL  isHiddenHeaderImage; //是否隐藏放大镜视图



@end

@protocol ALDTableViewIndexDelegate <NSObject>

/**
 *  触摸到索引时触发
 *
 *  @param tableViewIndex 触发didSelectSectionAtIndex对象
 *  @param index          索引下标
 *  @param title          索引文字
 */
- (void)tableViewIndex:(ALDTableViewIndex *)tableViewIndex didSelectSectionAtIndex:(NSInteger)index withTitle:(NSString *)title;

/**
 *  开始触摸索引
 *
 *  @param tableViewIndex 触发tableViewIndexTouchesBegan对象
 */
- (void)tableViewIndexTouchesBegan:(ALDTableViewIndex *)tableViewIndex;
/**
 *  触摸索引结束
 *
 *  @param tableViewIndex
 */
- (void)tableViewIndexTouchesEnd:(ALDTableViewIndex *)tableViewIndex;

/**
 *  TableView中右边右边索引title
 *
 *  @param tableViewIndex 触发tableViewIndexTitle对象
 *
 *  @return 索引title数组
 */
- (NSArray *)tableViewIndexTitle:(ALDTableViewIndex *)tableViewIndex;

- (void)searchButtonTouched;

@end
