//
//  ALDRadarUserViewController.m
//  ALDContactKit
//
//  Created by zyc on 15/8/19.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "ALDRadarUserViewController.h"

@interface ALDRadarUserViewController ()
@property (retain, nonatomic) IBOutlet UIButton *addFriendButton;
@property (retain, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (retain, nonatomic) IBOutlet UILabel *nameLabel;
@property (retain, nonatomic) IBOutlet UILabel *tipLabel;
@end

@implementation ALDRadarUserViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureUI];
    [self setBtnConfiguration];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    self.navigationController.navigationBarHidden = YES;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)setBtnConfiguration {
    [_addFriendButton setBackgroundColor:RGB(5, 172, 4,1)];
    [_addFriendButton setTitleColor:RGB(106, 217, 104,1) forState:UIControlStateDisabled];
}
- (void)configureUI
{
    //头像
    _avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-90)/2.0, 100, 90, 90)];
    _avatarImageView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:_avatarImageView];
    
    //姓名
    _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 198, self.view.bounds.size.width, 25)];
    _nameLabel.textColor = [UIColor whiteColor];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.font = [UIFont systemFontOfSize:17.0];
    _nameLabel.text = @"姓名";
    [self.view addSubview:_nameLabel];
    
    //提示
    _tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 225, self.view.bounds.size.width, 25)];
    _tipLabel.textColor = [UIColor lightGrayColor];
    _tipLabel.textAlignment = NSTextAlignmentCenter;
    _tipLabel.font = [UIFont systemFontOfSize:15.0];
    _tipLabel.text = @"提示";    //加好友按钮
    [self.view addSubview:_tipLabel];
    
    //加好友按钮
    _addFriendButton = [[UIButton alloc] initWithFrame:CGRectMake((self.view.bounds.size.width-180)/2.0, 328, 180, 36)];
    [_addFriendButton setTitle:@"添加好友" forState:UIControlStateNormal];
    [_addFriendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_addFriendButton.titleLabel setFont:[UIFont systemFontOfSize:15.0]];
    [_addFriendButton addTarget:self action:@selector(addFreind) forControlEvents:UIControlEventTouchUpInside];
    [_addFriendButton setBackgroundColor:RGB(26, 178, 10, 1)];
    [self.view addSubview:_addFriendButton];
    
}

-(void)addFreind
{
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//用户点击空白区域时返回上级界面
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self onCancel];
}
- (void)onCancel
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
