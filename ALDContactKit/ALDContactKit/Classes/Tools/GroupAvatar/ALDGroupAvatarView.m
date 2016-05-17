//
//  ALDGroupAvatar.m
//  ALDContactKit
//
//  Created by zyc on 15/8/11.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "ALDGroupAvatarView.h"
#import "UIImageView+ALDCache.h"
#define HeaderWidth 36
#define OneSecondOfWidth 16
#define OneThirdOfWidth 10

#define IMAGEVIEW_TAG_FIRST 10050
#define NewHost @"111.1.44.211"

@interface ALDGroupAvatarView()

@property (nonatomic, assign) float oneSecondOfWidth;
@property (nonatomic, assign) float oneThirdOfWidth;

@property (nonatomic,assign)  NSInteger headerCompleteNum;
@property (nonatomic,assign)  NSInteger headerType;

@property (strong, nonatomic) UIImageView * imgeBackgroundView;


@end

@implementation ALDGroupAvatarView
- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = RGB(234, 234, 234, 1);
        _imgeBackgroundView = [[UIImageView alloc]init];
        _imgeBackgroundView.frame = CGRectMake(0, 0, _HeaderHeight, _HeaderHeight);
        _imgeBackgroundView.hidden = NO;
//        _imgeBackgroundView.image = [UIImage imageNamed:@"aldGroupImage"];
        _imgeBackgroundView.contentMode = UIViewContentModeScaleAspectFill;
        
        [self addSubview:_imgeBackgroundView];
    }
    
    return self;
}
-(void)setDefaultImage:(UIImage *)image
{
    _imgeBackgroundView.image = image;
}

-(void)setUpaAsyncWithImageURLs:(NSArray *)imageURLs
{
    [self addSubImageViews:(int)imageURLs.count];
    
    [_imgeBackgroundView setFrame:CGRectMake(0, 0, _HeaderHeight, _HeaderHeight)];
    [self bringSubviewToFront:_imgeBackgroundView];
    _imgeBackgroundView.hidden = NO;
    
    for (int i = 0; i < imageURLs.count; i++) {
        
//       NSURL *url = [NSURL URLWithString:imageURLs[i]];
        
       UIImageView *imageView = (UIImageView*)[self viewWithTag:IMAGEVIEW_TAG_FIRST+i];
//       [imageView sd_setImageWithURL:url completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//          
//           _headerCompleteNum += 1;
//           [self detectionComplete];
//
//       }];
        [imageView imageWithURL:imageURLs[i] placeholderImage:nil completed:^(NSString *info, UIImage *image) {
            
                       _headerCompleteNum += 1;
                       [self detectionComplete];
        }];
//
        
    }
}
-(void)setUpWithImages:(NSArray *)images
{
    [self addSubImageViews:(int)images.count];
    
    _imgeBackgroundView.hidden = YES;

    for (int i = 0; i < images.count; i++) {
        
        UIImageView *imageView = (UIImageView*)[self viewWithTag:IMAGEVIEW_TAG_FIRST+i];

        [imageView setImage:images[i]];
        
    }}

-(void)setUpSyncWithImageURLs:(NSArray *)imageURLs;
{

    [self addSubImageViews:(int)imageURLs.count];
    _imgeBackgroundView.hidden = YES;


    for (int i = 0; i < imageURLs.count; i++) {

        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageURLs[i]]];
        
        UIImage *image = [UIImage imageWithData:imgData];
        UIImageView *imageView = (UIImageView*)[self viewWithTag:IMAGEVIEW_TAG_FIRST+i];
        [imageView setImage:image];
    }
}

- (void)addSubImageViews:(int)count
{
    _oneSecondOfWidth = (_HeaderHeight-6)/2+1;
    _oneThirdOfWidth = (_HeaderHeight -8)/3+1;
    
//    [_imgeBackgroundView removeFromSuperview];
    
    _headerCompleteNum = 0;
    NSInteger _uidsCout =count;
    _headerType = _uidsCout;
    if (_uidsCout>9) {
        _uidsCout = 9;
        _headerType = _uidsCout;
    }
    //    NSLog(@"--1---%@",_uids);
    
    for (int i = 0; i<9; i++) {
        int tag = i+IMAGEVIEW_TAG_FIRST;
        UIImageView *imgView = (UIImageView *)[self viewWithTag:tag];
        
        [imgView removeFromSuperview];
        [NSNumber numberWithFloat:2.0];
    }
    
//************************ 静态数组 ************************
//          一共几个         行数  列数   首行数
    int stateArray[10][3]= {{0,   0,    0},
                            {1,   1,    1},
                            {1,   2,    2},
                            {2,   2,    1},
                            {2,   2,    2},
                            {2,   3,    2},
                            {2,   3,    3},
                            {3,   3,    1},
                            {3,   3,    2},
                            {3,   3,    3}};
    
    //行数
    int arrY_count = stateArray[_uidsCout][0];

    //一行多少个
    int arrX_count = stateArray[_uidsCout][1];

    //第一行多少个
    int arrX_1_count = stateArray[_uidsCout][2];

    //单个大小
        float single_size = _uidsCout>4?_oneThirdOfWidth:(_uidsCout>1?_oneSecondOfWidth:_HeaderHeight-3);
    //起点
    float origin_X = (_uidsCout == 3 || _uidsCout == 5 || _uidsCout == 8)?single_size*0.5 :(_uidsCout == 7 ? single_size:0);
    float origin_Y = (_uidsCout == 2 || _uidsCout == 5 || _uidsCout == 6)?single_size*0.5 :0;
    
    
    for (int i = 0; i < arrX_count; i ++) {
        
        for (int j = 0; j < arrY_count; j ++) {
            
            UIImageView *imageView;
            //第一行
            if (j == 0) {
                
                if (i< arrX_1_count) {
                    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(1.5+origin_X+(single_size+1)*i, 1.5+origin_Y+((single_size+1)*j), single_size, single_size)];
                    
                    imageView.tag = IMAGEVIEW_TAG_FIRST+i;
                }
            }else{
                imageView = [[UIImageView alloc] initWithFrame:CGRectMake(1.5+(single_size+1)*i, 1.5+origin_Y + ((single_size+1)*j), single_size, single_size)];
                imageView.tag = IMAGEVIEW_TAG_FIRST+arrX_1_count + (j-1)*arrX_count + i;
            }
            
            imageView.backgroundColor = [UIColor lightGrayColor];
            
            if (imageView) {
//                imageView.image = self.images[imageView.tag - IMAGEVIEW_TAG_FIRST];
                [self addSubview:imageView];
            }
            
        }
    }

}
-(void)detectionComplete
{
    if (_headerCompleteNum == _headerType)
    {
        _imgeBackgroundView.hidden = YES;
        NSLog(@"完成==========================%zd",_headerCompleteNum);
    }
}
@end
