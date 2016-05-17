//
//  PhoneContactsViewController.m
//  ALDContactKit
//
//  Created by zyc on 15/8/12.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "PhoneContactsViewController.h"
#import "ALDPhoneContacts.h"

@interface PhoneContactsViewController ()
@property (nonatomic,retain) NSArray *contactsList;
@end
@implementation PhoneContactsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    __weak typeof(self) weakSelf = self;
    [ALDPhoneContacts addressBookIdentification:^(NSString *info, NSMutableArray *contacts) {
 
        NSLog(@"%@",info);

        if ([info isEqualToString:ADDRESS_TPYE_HINT_SUECESS] || [info isEqualToString:ADDRESS_TPYE_SUECESS]) {
            weakSelf.contactsList = contacts;
            [weakSelf.tableView reloadData];
        }else{
            [[[UIAlertView alloc] initWithTitle:@"提示" message:info delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil] show];
         }
        
    }];
    
    NSLog(@"%@",self.contactsList);
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contactsList.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    cell.textLabel.text =self.contactsList[indexPath.row][ALDMOBILE_NAME];
    cell.detailTextLabel.text = self.contactsList[indexPath.row][ALDMOBILE_NUMBER];
    
    return cell;
}
@end
