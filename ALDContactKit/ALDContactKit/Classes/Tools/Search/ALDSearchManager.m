//
//  ALDSearchManager.m
//  ALDContactKit
//
//  Created by zyc on 15/8/17.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "ALDSearchManager.h"
#import "ALDPinYinForObjc.h"
#import "ALDChineseInclude.h"

@implementation ALDSearchManager
+(NSArray *)filterFromArray:(NSArray *)array searchString:(NSString *)string highlightColor:(UIColor *)color
{
    
    NSMutableArray *searchResults = [NSMutableArray arrayWithCapacity:0];
    if (string.length>0&&![ALDChineseInclude isIncludeChineseInString:string]) { //匹配字段 全英文
        for (int i=0; i<array.count; i++) {
            if ([ALDChineseInclude isIncludeChineseInString:array[i]]) {   //列表 字段中有中文
                
        
                NSString *tempPinYinStr = [ALDPinYinForObjc chineseConvertToPinYin:array[i]];
                NSRange titleResult=[tempPinYinStr rangeOfString:string options:NSCaseInsensitiveSearch];
                
                if (titleResult.length>0) {
                    [searchResults addObject:array[i]];
                }else{
                    //首字母缩写匹配
                    NSString *tempPinYinHeadStr = [ALDPinYinForObjc chineseConvertToPinYinHead:array[i]];
                    NSRange titleHeadResult=[tempPinYinHeadStr rangeOfString:string options:NSCaseInsensitiveSearch];
                    if (titleHeadResult.length>0) {
                        [searchResults addObject:array[i]];
                    }
                }

            }
            else {     //列表字段 全英文
                NSRange titleResult=[array[i] rangeOfString:string options:NSCaseInsensitiveSearch];
                if (titleResult.length>0) {
                    [searchResults addObject:array[i]];
                }
            }
        }
    } else if (string.length>0&&[ALDChineseInclude isIncludeChineseInString:string]) {   //匹配字段中有中文
        for (NSString *tempStr in array) {
            NSRange titleResult=[tempStr rangeOfString:string options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [searchResults addObject:tempStr];
            }
        }
    }
    
    
    if (color) {
        NSMutableArray *searchResults_AttributString = [NSMutableArray arrayWithCapacity:searchResults.count];
        for (NSString *str in searchResults) {
            
            NSRange range = [str rangeOfString:string options:NSCaseInsensitiveSearch];
            NSMutableAttributedString *attributString = [[NSMutableAttributedString alloc] initWithString:str];
            [attributString addAttribute:NSForegroundColorAttributeName value:color range:range];

            [searchResults_AttributString addObject:attributString];
            
        }
        
        return [NSArray arrayWithArray:searchResults_AttributString];

    }else{
        
        return  [NSArray arrayWithArray:searchResults];
    }
    
    
}
+(NSArray *)filterContentFromArray:(NSArray *)array searchString:(NSString *)string highlightColor:(UIColor *)color;
{
    NSMutableArray *searchResults = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray *searchResults_AttributString = [NSMutableArray arrayWithCapacity:0];

        for (NSString *tempStr in array) {
            NSRange titleResult=[tempStr rangeOfString:string options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                
                if (color) {
                    NSMutableAttributedString *attributString = [[NSMutableAttributedString alloc] initWithString:tempStr];
                    [attributString addAttribute:NSForegroundColorAttributeName value:color range:titleResult];
                    [searchResults_AttributString addObject:attributString];
                }else{
                    [searchResults addObject:tempStr];
                }
            }
        }
    return color?[NSArray arrayWithArray:searchResults_AttributString]:[NSArray arrayWithArray:searchResults];
}

@end
