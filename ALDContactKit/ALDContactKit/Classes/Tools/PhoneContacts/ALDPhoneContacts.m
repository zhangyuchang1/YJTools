//
//  ALDPhoneContacts.m
//  ALDContactKit
//
//  Created by zyc on 15/8/12.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "ALDPhoneContacts.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>

@interface ALDPhoneContacts ()

+(NSMutableArray *)addressBookFromPhone;


@end

@implementation ALDPhoneContacts


+(NSMutableArray *)addressBookFromPhone
{
    ABAddressBookRef addressBook;

    addressBook = ABAddressBookCreateWithOptions(NULL, NULL);

    // 处理通讯录数据
    NSMutableArray *personArray = (NSMutableArray *)CFBridgingRelease(ABAddressBookCopyArrayOfAllPeople(addressBook));
    
    NSMutableArray *memberList = [[NSMutableArray alloc] init];
    for (int i = 0; i < [personArray count]; i++)
    {
        NSMutableDictionary *thePerson = [[NSMutableDictionary alloc] init];
        
        // 取出姓名
        id person = [personArray objectAtIndex:i];
        NSString * firstName = (__bridge NSString *)ABRecordCopyValue(CFBridgingRetain(person), kABPersonFirstNameProperty);
        NSString * middleName = (__bridge NSString *)ABRecordCopyValue(CFBridgingRetain(person), kABPersonMiddleNameProperty);
        NSString * lastName = (__bridge NSString *)ABRecordCopyValue(CFBridgingRetain(person), kABPersonLastNameProperty);
        NSMutableString * fullName = [[NSMutableString alloc] init];
        
        if (lastName != nil && ![lastName isEqual:NULL])
        {
            [fullName appendString:lastName];
        }
        
        if (middleName != nil && ![middleName isEqual:NULL])
        {
            [fullName appendString:middleName];
        }
        
        if (firstName != nil && ![firstName isEqual:NULL])
        {
            [fullName appendString:firstName];
        }
        
        
        // 取出电话
        //MyLog(@"===%@",fullName);
        ABMultiValueRef phones = (ABMultiValueRef) ABRecordCopyValue(CFBridgingRetain(person), kABPersonPhoneProperty);
        
        //add by robin create model
        
        NSMutableArray *thePhone = [[NSMutableArray alloc] init];
        for(int i = 0 ;i < ABMultiValueGetCount(phones); i++)
        {
            NSString *phone = (NSString *)CFBridgingRelease(ABMultiValueCopyValueAtIndex(phones, i));
            //MyLog(@"===%@",phone);
            if (phone.length > 0)
            {
                NSString *newPhone1 = [phone stringByReplacingOccurrencesOfString:@"-" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [phone length])];
                NSString *newPhone2 = [newPhone1 stringByReplacingOccurrencesOfString:@"(" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [newPhone1 length])];
                NSString *newPhone3 = [newPhone2 stringByReplacingOccurrencesOfString:@")" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [newPhone2 length])];
                NSString *newPhone4 = [newPhone3 stringByReplacingOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [newPhone3 length])];
                NSString *newPhone5 = [newPhone4 stringByReplacingOccurrencesOfString:@"+" withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [newPhone4 length])];
                NSString *newPhone7 = [newPhone5 stringByReplacingOccurrencesOfString:@" " withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0, [newPhone5 length])];
                
                if(newPhone7.length >= 11)
                {
                    NSRange range = NSMakeRange(newPhone7.length-11, 11);
                    NSString *newPhone6 = [newPhone7 substringWithRange:range];
                    [thePhone addObject:newPhone6];
                }
                else
                {
                    [thePhone addObject:newPhone7];
                }
            }
            
        }
        
        if(thePhone.count == 0){
            
            
            continue;
        }
        NSString *myMobile = [[[NSUserDefaults standardUserDefaults] objectForKey:@"user"] objectForKey:@"account"];
        for(id object in thePhone)
        {
            
            if (![object isEqualToString:myMobile])
            {
                if ([fullName isEqualToString:@""])
                {
                    [thePerson setObject:object forKey:ALDMOBILE_NAME];
                    [thePerson setObject:object forKey:ALDMOBILE_NUMBER];
                    
                }
                else
                {
                    [thePerson setObject:fullName forKey:ALDMOBILE_NAME];
                    [thePerson setObject:object forKey:ALDMOBILE_NUMBER];
                }
                NSMutableDictionary *thePersonIdentify = [NSMutableDictionary dictionaryWithDictionary:thePerson];
                //过滤自己的号码
                //                NSString *userMobileNo = [[NSUserDefaults standardUserDefaults]objectForKey:EIM_Username];
                
                //                if (![[thePersonIdentify objectForKey:@"mobileNo"] isEqualToString:userMobileNo]) {
                [memberList addObject:thePersonIdentify];
                
            }
        }
        
    }
    
    return  memberList;
}

/*************************************************************************************
                        ABAddressBookGetAuthorizationStatus
                        函数可以查询对通讯录的访问权限
                        kABAuthorizationStatusNotDetermined
                        用户还没有决定是否授权你的程序进行访问
                        kABAuthorizationStatusRestricted
                        iOS设备上的家长控制或其它一些许可配置阻止程序与通讯录数据库进行交互
                        kABAuthorizationStatusDenied
                        用户明确的拒绝了你的程序对通讯录的访问
                        kABAuthorizationStatusAuthorized
                        用户已经授权给你的程序对通讯录进行访问

*************************************************************************************/

+(void)addressBookIdentification:(void(^)(NSString *info, NSMutableArray *contacts))block;
{
    
        ABAddressBookRef book = ABAddressBookCreateWithOptions(NULL, NULL);
        ABAuthorizationStatus addressAccessStatus = ABAddressBookGetAuthorizationStatus();
        switch (addressAccessStatus)
        {
            case kABAuthorizationStatusAuthorized:
            {
                
                NSMutableArray *list = [ALDPhoneContacts addressBookFromPhone];
                NSString *info = ADDRESS_TPYE_SUECESS;
                block(info,list);
            }
                break;
            case kABAuthorizationStatusNotDetermined:
                //首次 系统提醒
            {
                ABAddressBookRequestAccessWithCompletion(book, ^(bool granted, CFErrorRef error){
                    if(granted){
                        
                        NSMutableArray *list = [ALDPhoneContacts addressBookFromPhone];
                        NSString *info = ADDRESS_TPYE_HINT_SUECESS;
                        block(info,list);

                    }else{
                        NSString *info = ADDRESS_TPYE_HINT_REJECT;

                        block(info,nil);
                    }
                    
                });
            }
                break;
            case kABAuthorizationStatusRestricted:
            {

                NSString *info = ADDRESS_TPYE_REJECT;
                block(info,nil);

            }
                break;
            case kABAuthorizationStatusDenied:
            {

                NSString *info = ADDRESS_TPYE_REJECT;
                block(info,nil);
            }
                break;
            default:
                break;
        }
  }

@end
