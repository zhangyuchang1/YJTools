//
//  GroupAvatarViewController.m
//  ALDContactKit
//
//  Created by zyc on 15/8/11.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "GroupAvatarViewController.h"
#import "ALDGroupAvatarView.h"

#define BUTTON_SIZE   60
#define NewHost @"111.1.44.211"

@interface GroupAvatarViewController ()

@property (nonatomic,retain) ALDGroupAvatarView *groupAvatarView;
@property (nonatomic,retain) NSMutableArray *uids;
@property (nonatomic,retain) NSMutableArray *images;
@property (nonatomic,retain) NSMutableArray *imgURLs;


@end

@implementation GroupAvatarViewController


-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    
    self.uids = [NSMutableArray array];
    self.images = [NSMutableArray array];
    self.imgURLs = [NSMutableArray array];
    
    [self addSubViews];
}

-(void)addSubViews
{
    ALDGroupAvatarView *groupAvatarView = [[ALDGroupAvatarView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-100)/2.0, 130, 100, 100)];
    groupAvatarView.HeaderHeight = 100;
//    [groupAvatarView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"aldGroupImage"]]];
    [self.view addSubview:groupAvatarView];
    
    self.groupAvatarView = groupAvatarView;
    
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height-240, self.view.bounds.size.width, 240)];
    bottomView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:bottomView];
    
    for (int i = 0; i<4; i++) {
        for (int j = 0; j<3; j++) {
            
            UIButton *button = [[UIButton alloc] init];
            [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
            button.tag = 100000+j*4+i;
            
            button.frame = CGRectMake((self.view.bounds.size.width-320)/2.0 +10 + i*(BUTTON_SIZE+20), 10 + j*(BUTTON_SIZE+20), BUTTON_SIZE, BUTTON_SIZE);
            button.backgroundColor = [UIColor yellowColor];
            
//            NSString* urlString = [NSString stringWithFormat:@"http://%@/%ld/face.jpg",NewHost,(long)button.tag];
//aLdNewFriendsDefault
            UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"aldUserHeader_image_%d",1+j*4+i]];
            
            [button setBackgroundImage:image forState:UIControlStateNormal];
//            [button sd_setBackgroundImageWithURL:[NSURL URLWithString:urlString] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"aLdNewFriendsDefault"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//                
//            
//            }];
            [bottomView addSubview:button];
        }
  
    }
}

-(void)selected:(UIButton *)button
{
    
    NSString *string = [NSString stringWithFormat:@"%ld",(long)button.tag];
    NSString *urlString = [NSString stringWithFormat:@"http://%@/%ld/face.jpg",NewHost,(long)button.tag];
    if (button.selected == YES ) {
        button.selected = NO;
        button.layer.borderColor = [UIColor clearColor].CGColor;
        [self.uids removeObject:string];
        [self.images removeObject:button.currentBackgroundImage];
        [self.imgURLs removeObject:urlString];
        
    }else{
        button.selected = YES;
        
        button.layer.borderColor = [UIColor redColor].CGColor;
        button.layer.borderWidth = 5.0;
        [self.uids addObject:string];
        [self.images addObject:button.currentBackgroundImage];
        [self.imgURLs addObject:urlString];
    }
    

    
//    [self meathed_images];
    
    [self meathed_urls];
    
}

#pragma mark - 设置群组头像不同的方法

//方法1：设置图像数组
- (void)meathed_images
{
    [self.groupAvatarView setDefaultImage:[UIImage imageNamed:@"aldGroupImage"]];

    [self.groupAvatarView setUpWithImages:self.images];
}
//方法2：用图片的URL  数组
- (void)meathed_urls
{
//    [self.groupAvatarView setDefaultImage:[UIImage imageNamed:@"aldGroupImage"]];
    [self.groupAvatarView setUpaAsyncWithImageURLs:self.imgURLs];
}



@end
