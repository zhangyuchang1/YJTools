//
//  ALDImageDownloadManager.m
//  ALDContactKit
//
//  Created by zyc on 15/8/20.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "ALDImageDownloadManager.h"

@implementation ALDImageDownloadManager

+ (ALDImageDownloadManager *)sharedManager
{
    static ALDImageDownloadManager *sharedManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        sharedManagerInstance = [[self alloc] init];
    });
    return sharedManagerInstance;
}

- (NSURL *)urlWithName:(NSString *)name{

    NSURL *url;
    NSString *httpStr = @"http://";
    if (![name hasPrefix:httpStr]) {
        url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",httpStr,name]];
    }else{
        url = [NSURL URLWithString:name];
    }
    
    return url;
}

- (NSString *)getFilePath:(NSString *)name {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSString *filePath = [self getImageFilePath];
    
    if (![fm fileExistsAtPath:filePath]) {
        //子文件夹若不存在，创建子文件夹  //防止同步
        {
            [fm createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
            [self addSkipBackupAttributeToItemAtURL:[NSURL fileURLWithPath:filePath]];

        }
    }
    
//    /Documents/ContactKit.imageCache/111.1.44.211/100002/face.jpg
    NSString *fullPath_jgp = [filePath stringByAppendingString:[NSString stringWithFormat:@"/%@",name]];
//    /face.jpg 去掉
    NSArray *strs = [fullPath_jgp componentsSeparatedByString:@"/"];
    NSString *nameStr = [strs lastObject];
    NSMutableString *mut_str = [NSMutableString stringWithString:fullPath_jgp];
    NSRange rang = [mut_str rangeOfString:nameStr];
    [mut_str deleteCharactersInRange:rang];
    NSString *fullPath = [NSString stringWithString:mut_str];
    
    if (![fm fileExistsAtPath:fullPath]) {
        //子文件夹若不存在，创建子文件夹
        {
            [fm createDirectoryAtPath:fullPath withIntermediateDirectories:YES attributes:nil error:nil];
        }
    }
    
    return fullPath_jgp;
}

//缓存文件夹
- (NSString*)getImageFilePath
{
    NSString *fullNamespace = @"ContactKit.imageCache";

    // Init the disk cache
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *diskCachePath = [paths[0] stringByAppendingPathComponent:fullNamespace];

    return diskCachePath;
}

// 防止iCloud备份非用户产生的数据
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
    
    NSError *error = nil;
    BOOL success = [URL setResourceValue: [NSNumber numberWithBool: YES]
                                  forKey: NSURLIsExcludedFromBackupKey error: &error];
    if(!success){
        NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    }
    return success;
}
@end
