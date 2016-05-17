//
//  RadarViewController.m
//  ALDContactKit
//
//  Created by zyc on 15/8/18.
//  Copyright (c) 2015年 zyc. All rights reserved.
//



#import "RadarViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "ALDRadarItem.h"


@interface RadarViewController ()
@property (nonatomic,retain)   NSTimer     *timer;
@property (retain, nonatomic)  UIImageView *avatarImageView;
@property (retain, nonatomic)  UIImageView *radarImageView;
@property (nonatomic,retain)   NSMutableArray     *friendItemList;
@property (nonatomic, strong)  AVAudioPlayer *player;
@property (strong, nonatomic)  UIView     *imageView;

@property (nonatomic,retain)  NSMutableArray *randomPoints;    //随机12个点

@end

@implementation RadarViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configUI];
    
    self.randomPoints = [self setPoints];
    self.friendItemList = [NSMutableArray array];
}

- (void)configUI
{
    //背景
    _imageView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    _imageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:_imageView];
    
    //雷达多环图
    _radarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-34, (self.view.bounds.size.height - 64 - 450)/2.0+64, self.view.bounds.size.width+68, 450)];
//    _radarImageView.backgroundColor = [UIColor greenColor];
    [_radarImageView setContentMode:UIViewContentModeCenter];
    [_radarImageView setImage:[UIImage imageNamed:@"aldBackgroundlight"]];
    [self.view addSubview:_radarImageView];
    
    //自己头像
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width -84)/2.0, (self.view.bounds.size.height - 64 - 84)/2.0+64, 84, 84)];
    _avatarImageView.backgroundColor = [UIColor redColor];
    _avatarImageView.layer.cornerRadius = 43.0f;
    _avatarImageView.layer.masksToBounds = YES;
    [_avatarImageView setImage:[UIImage imageNamed:@"aldUserHeader_image_11"]];

    [self.view addSubview:_avatarImageView];
    
    
    //退出按钮
    UIButton *backButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 34, 47, 30)];
    backButton.layer.borderColor = RGB(75, 198, 200, 1).CGColor;
    backButton.layer.borderWidth = 1.0f;
    backButton.layer.cornerRadius = 4.0f;
    [backButton setTitle:@"退出" forState:UIControlStateNormal];
    backButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [backButton setTitleColor:RGB(75, 198, 200, 1) forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(onCancel:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    
    //test  搜到人
    UIButton *addUserButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 67 - 20, 34, 67, 30)];
//    addUserButton.backgroundColor = [UIColor yellowColor];
    [addUserButton setTitle:@"加一人" forState:UIControlStateNormal];
    addUserButton.titleLabel.textColor = [UIColor whiteColor];
    [addUserButton addTarget:self action:@selector(addOneUser) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addUserButton];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
        [[UIApplication sharedApplication] setStatusBarHidden:YES];
        self.navigationController.navigationBarHidden = YES;
    
//    [[EIMKit sharedInstance] addObserver:self forKeyPath:@"radarFriends" options:NSKeyValueObservingOptionNew context:nil];
//    
//    NSString* xs = [NSString stringWithFormat:@"%f",[ALDLocationProvider sharedInstance].currentLocation.coordinate.longitude];
//    NSString* ys = [NSString stringWithFormat:@"%f",[ALDLocationProvider sharedInstance].currentLocation.coordinate.latitude];
//    [EIMKit startWithXs:xs ys:ys];
    
    [self startTimer];
    [self setImageViewPictureRotation];
    [self playAudioMusic];
    
//    EIMUser* user = [EIMKit sharedInstance].currentUser;
//    NSString* urlString = [NSString stringWithFormat:@"http://%@/%@/face.jpg",NewHost,user.uid];
//    [_avatarImageView setImage:[UIImage imageNamed:@"player"]];
    
    //注册一个通知
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    self.navigationController.navigationBarHidden = NO;
    
//    [[EIMKit sharedInstance] removeObserver:self forKeyPath:@"radarFriends" context:nil];
//    [[NSNotificationCenter defaultCenter]removeObserver:self name:EIMRadarUpdateNotification object:nil];
    //    [EIMKit remove];
    //    [EIMKit sharedInstance].radarFriends = nil;
    
    [_timer invalidate];
    _timer = nil;
    
    [_player stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - methods
- (void)radarUpdate:(NSNotification*)notification
{
    //    //别人同意我的请求
    //    NSArray* friendList = [EIMKit sharedInstance].radarFriends;
    //    NSMutableArray * empty = [NSMutableArray array];
    //    for (EIMUser* user in friendList)
    //    {
    //        if ([user.uid isEqualToString:reData[@"fid"]]) {
    //            user.state = @"22";
    //            [empty addObject:user];
    //        }
    //        else
    //            [empty addObject:user];
    //    }
    //    [EIMKit sharedInstance].radarFriends = [NSArray arrayWithArray:empty];
    
    [self refresh];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"radarFriends"])
    {
        [self refresh];
    }
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

#pragma mark - Methods
- (void)setImageViewPictureRotation
{
    if (K_SCREEN_WIDTH == 320 && K_SCREEN_HEIGHT == 480) {
        _radarImageView.image = [UIImage imageNamed:@"aldBackgroundlight4s"];
    }

    
    _imageView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"aldBackgroundColorOne"]];
    
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
    rotationAnimation.duration = 3;
    rotationAnimation.cumulative = YES;
    rotationAnimation.repeatCount = MAXFLOAT;
    
    [self.radarImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
}

- (void)playAudioMusic
{
    _player =[[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"radarAudio" ofType:@"mp3"]] error:nil];
    _player.volume = 1;
    _player.numberOfLoops  = -1;
    [_player play];
}

#pragma mark - UI Action

- (IBAction)onCancel:(id)sender
{
    //给服务器发一个退出雷达的请求
 
    
    [_player stop];
    _radarImageView.image = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)addOneUser
{
    int i = (int)self.friendItemList.count;

    NSString *str = [NSString stringWithFormat:@"aldUserHeader_image_%d",i+1];
    [self.friendItemList addObject:str];
    
     CGPoint point = [self getRectFromRander:i];
    if (point.x == 0 && point.y == 0) {
        NSLog(@"最多显示11个");
        return;
    }
    
    ALDRadarItem *radarItem = [[ALDRadarItem alloc] initWithX:point.x andY:point.y];
    
    [self.view addSubview:radarItem];
    
    
    
   
    
}
#pragma mark - Util

- (void)startTimer
{
    //写个时间定时器,15秒执行一次startSocketUpdate函数
    if (!_timer) {
        _timer=[NSTimer scheduledTimerWithTimeInterval:15
                                                target: self
                                              selector: @selector(update)
                                              userInfo: nil
                                               repeats: YES];
        
        [_timer setFireDate:[NSDate distantPast]];
    }
}

- (void)update
{
//    NSString* xs = [NSString stringWithFormat:@"%f",[ALDLocationProvider sharedInstance].currentLocation.coordinate.longitude];
//    NSString* ys = [NSString stringWithFormat:@"%f",[ALDLocationProvider sharedInstance].currentLocation.coordinate.latitude];
//    [EIMKit updateWithXs:xs ys:ys];
}

- (void)refresh
{
    
    /*
    // 1.移除
    for (ALDRadarItemViewController* vc in _friendItemList)
    {
        [vc.view removeFromSuperview];
    }
    
    NSArray* friendList = [EIMKit sharedInstance].radarFriends;
    
    NSMutableArray* temp = [NSMutableArray array];
    int i = 0;
    for (EIMUser* user in friendList)
    {
        ALDRadarItemViewController* vController = [self.storyboard instantiateViewControllerWithIdentifier:@"ALDRadarItemViewController"];
        [vController setRadarTouchCompletion:^(EIMUser *user){
            ALDRadarUserViewController* viewController = [self.storyboard instantiateViewControllerWithIdentifier:@"ALDRadarUserViewController"];
            viewController.user = user;
            [self.navigationController pushViewController:viewController animated:YES];
        }];
        vController.user = user;
        CGPoint point = [self getRectFromRander:i];
        vController.x = point.x;
        vController.y = point.y;
        [temp addObject:vController];
        i++;
    }
    _friendItemList = [NSArray arrayWithArray:temp];
    
    // 2.添加
    for (ALDRadarItemViewController* vc in _friendItemList)
    {
        [self.view addSubview:vc.view];
    }
     
     */
}



#pragma mark - View Frame
- (CGPoint)getRectFromRander:(NSInteger)i
{
    if (self.randomPoints.count<2) {
        return CGPointZero;
    }
    //随机抽取一个
    int index = arc4random()%self.randomPoints.count -1;
    if (index < 0) {
        index +=1;
    }
    
    NSValue *randomV = self.randomPoints[index];
    CGPoint randomPoint = [randomV CGPointValue];
    [self.randomPoints removeObject:randomV];
    
    CGPoint center = self.view.center;
    
    CGPoint origin =CGPointMake(center.x + randomPoint.x, center.y + randomPoint.y);
    

    
    return origin;
}

-(NSMutableArray *)setPoints
{
    
    CGPoint p1 = {60,-32};
    CGPoint p2 = {-84,-125};
    CGPoint p3 = {-105,44};
    CGPoint p4 = {60,67};
    CGPoint p5 = {-99,135};
    CGPoint p6 = {54,-127};
    CGPoint p7 = {-45,-200};
    CGPoint p8 = {-180,-20};
    CGPoint p9 = {-20,-140};
    CGPoint p10 = {-18,-65};
    CGPoint p11 = {-155,-80};
    CGPoint p12 = {0,130};

    NSValue *v1 = [NSValue valueWithCGPoint:p1];
    NSValue *v2 = [NSValue valueWithCGPoint:p2];
    NSValue *v3 = [NSValue valueWithCGPoint:p3];
    NSValue *v4 = [NSValue valueWithCGPoint:p4];
    NSValue *v5 = [NSValue valueWithCGPoint:p5];
    NSValue *v6 = [NSValue valueWithCGPoint:p6];
    NSValue *v7 = [NSValue valueWithCGPoint:p7];
    NSValue *v8 = [NSValue valueWithCGPoint:p8];
    NSValue *v9 = [NSValue valueWithCGPoint:p9];
    NSValue *v10 = [NSValue valueWithCGPoint:p10];
    NSValue *v11 = [NSValue valueWithCGPoint:p11];
    NSValue *v12 = [NSValue valueWithCGPoint:p12];
    
    NSMutableArray *points = [NSMutableArray arrayWithObjects:v1,v2,v3,v4,v5,v6,v7,v8,v9,v10,v11,v12, nil];

    return points;
}
@end
