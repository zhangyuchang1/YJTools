//
//  ALDRadarItem.m
//  ALDContactKit
//
//  Created by zyc on 15/8/19.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "ALDRadarItem.h"
#import "ALDRadarUserViewController.h"

@interface UIView (UIViewController)

/**
 * 获取当前视图的控制器
 */
- (UIViewController*)viewController;

@end

@implementation UIView (UIViewController)

- (UIViewController*)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

@end

@interface ALDRadarItem()
@property (strong, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (strong, nonatomic) IBOutlet UILabel     *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *stateBgImage;
@end

@implementation ALDRadarItem

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
    }

    return self;
}
- (instancetype)initWithX:(int)x andY:(int)y
{
    self = [super initWithFrame:CGRectZero];
    
    if (self) {
        [self setFrame:CGRectMake(x, y, 100, 80)];
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubViews];
    }
    
    
    _avatarImageView.image = [UIImage imageNamed:@"aldUserHeader_image_1"];
    _nameLabel.text = @"张三";
    _stateBgImage.image = [UIImage imageNamed:@"aldPlayPetty"];
    
    return self;
}

-(void)addSubViews
{
    //是否是好友的imageView
    _stateBgImage = [[UIImageView alloc] initWithFrame:CGRectMake(38, 40, 54, 19)];
    _stateBgImage.backgroundColor = [UIColor clearColor];
    [self addSubview:_stateBgImage];
    
    //头像
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18, 0, 60, 60)];
    _avatarImageView.backgroundColor = [UIColor clearColor];
    _avatarImageView.layer.borderColor = [UIColor colorWithRed:84.0f/225 green:173.0f/255 blue:198.0f/225 alpha:0.8].CGColor;
    _avatarImageView.layer.borderWidth = 1.5;
    _avatarImageView.layer.cornerRadius = 30.0;
    _avatarImageView.layer.masksToBounds = YES;
    [self addSubview:_avatarImageView];
    
    //姓名
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, 100, 49)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.backgroundColor = [UIColor clearColor];
    
    //点击
    UIButton *button = [[UIButton alloc] initWithFrame:self.bounds];
    [button addTarget:self action:@selector(tototototot) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
}
-(void)tototototot
{
    ALDRadarUserViewController *radarUserViewController = [[ALDRadarUserViewController alloc] init];
    
    [self.viewController.navigationController pushViewController:radarUserViewController animated:YES];
    
}
//- (void)viewDidLoad
//{
//    [super viewDidLoad];
//    _avatarImageView.layer.borderColor = [UIColor colorWithRed:84.0f/225 green:173.0f/255 blue:198.0f/225 alpha:0.8].CGColor;
//    _avatarImageView.layer.borderWidth = 1.5;
//}

//- (void)viewWillAppear:(BOOL)animated
//{
//    [super viewWillAppear:animated];
//    self.view.hidden = YES;
//    
//    NSString* urlString = [NSString stringWithFormat:@"http://%@/%@/face.jpg",NewHost,_user.uid];
//    [_avatarImageView sd_setImageWithURL:[NSURL URLWithString:urlString] placeholderImage:[UIImage imageNamed:@"aLdNewFriendsDefault"]];
//    NSString *uid = [EIMKit sharedInstance].currentUser.uid;
//    if (!uid) {
//        uid = @"0";
//    }
//    
//    [EIMKit userWithUid:uid fid:_user.uid andBlock:^(EIMUser *user) {
//        //        if (user.nicker.length > 0)
//        //            _nameLabel.text = user.nicker;
//        //        else
//        //            _nameLabel.text = _user.Nicer;
//        if (user.nicker.length > 0)
//            _nameLabel.text = user.nicker;
//        else
//            _nameLabel.text = user.Nicer;
//        
//        if ([user.state isEqualToString:@"21"]) {
//            _stateBgImage.image = [UIImage imageNamed:@"aldPlayPetty"];
//        }else if ([user.state isEqualToString:@"11"])
//        {
//            _stateBgImage.image = [UIImage imageNamed:@"aldWait"];
//        }else if ([user.state isEqualToString:@"12"] || [user.state isEqualToString:@"22"])
//        {
//            _stateBgImage.image = [UIImage imageNamed:@"aldAddedSuccessfully"];
//        }else
//        {
//            _stateBgImage.hidden = YES;
//            //            _nameLabel.text = _u
//        }
//    }];
//}
//
//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    self.view.hidden = NO;
//    self.view.frame = CGRectMake(_x, _y, 100, 80);
//    self.view.alpha = 0;
//    [UIView animateWithDuration:0.3 animations:^{
//        self.view.alpha = 1;
//    }];
//}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - UI Action

- (IBAction)onFriend:(id)sender
{
    //    ALDRadarUserViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ALDRadarUserViewController"];
    //    viewController.user = _user;
    //    [self presentViewController:viewController animated:YES completion:NULL];
    
    if (_radarTouchCompletion) {
        _radarTouchCompletion(_user);
    }
}

@end
