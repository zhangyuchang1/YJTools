//
//  CkeckViewController.m
//  ALDContactKit
//
//  Created by zyc on 15/8/18.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "CkeckViewController.h"
#import "ALDStringCheck.h"

@interface CkeckViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextfeild;
@property (weak, nonatomic) IBOutlet UITextField *passwardTextfeild;
@property (weak, nonatomic) IBOutlet UITextField *birthdayTextfeild;
@property (weak, nonatomic) IBOutlet UITextField *phoneTextfeild;
@property (weak, nonatomic) IBOutlet UITextField *mailTextfeild;

@end

@implementation CkeckViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITextField Delegate
- (IBAction)textEdited:(UITextField *)sender {
    
    if (sender == _nameTextfeild) {
        
        if (![ALDStringCheck validateUserName:sender.text]) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"用户名格式不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }
    
    if (sender == _passwardTextfeild) {
        
        if (![ALDStringCheck validateUserPasswd:sender.text]) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"密码格式不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }
    
    if (sender == _birthdayTextfeild) {
        
        if (![ALDStringCheck validateUserBornDate:sender.text]) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"生日格式不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }
    if (sender == _phoneTextfeild) {
        
        if (![ALDStringCheck validateUserPhone:sender.text]) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"手机号格式不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }
    if (sender == _mailTextfeild) {
        
        if (![ALDStringCheck validateUserEmail:sender.text]) {
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"邮箱格式不正确" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
        }
    }
}

@end
