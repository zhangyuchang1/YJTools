//
//  UIImageView+ALDCache.m
//  ALDContactKit
//
//  Created by zyc on 15/8/20.
//  Copyright (c) 2015年 zyc. All rights reserved.
//

#import "ALDImageDownloadManager.h"
#import "UIImageView+ALDCache.h"

static NSMutableDictionary *imageCache;
static NSOperationQueue *queue;

@implementation UIImageView (ALDCache)

- (void)downloadImage:(NSString *)name cache:(BOOL)cache completed:(void(^)(NSString *info,UIImage *UIImage))completedBlock;
{
    //创建操作队列
    if (queue == nil) {
        queue = [[NSOperationQueue alloc] init];
        queue.maxConcurrentOperationCount = 9;  //设置最大并发线程数
    }
    [queue addOperationWithBlock:^{
        // 处理耗时操作的代码块...
        NSURL *url = [[ALDImageDownloadManager sharedManager] urlWithName:name];

                NSURLRequest *request = [NSURLRequest requestWithURL:url
                                                         cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                     timeoutInterval:10.0f];
                NSHTTPURLResponse *response;
                NSError *error;
                NSData *receiveData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
                if (!error) {
                    if (cache && receiveData) {
                        //保存成文件
                        NSString *pngFilePath = [[ALDImageDownloadManager sharedManager] getFilePath:name];
                        [receiveData writeToFile:pngFilePath atomically:YES];

                        UIImage *image = [UIImage imageWithData:receiveData];
                        if (image) {
                            //通知主线程刷新
                            dispatch_async(dispatch_get_main_queue(), ^{
                                self.image = image;
                                //加载到内存
                                [self saveToImageCache:image byKey:[NSString stringWithFormat:@"%@", name]];
                            });
                            
                            completedBlock(@"网络下载",image);
                        }
                        
                    }
              
                }

    }];
}

- (void)saveToImageCache:(UIImage *)image byKey:(NSString *)key
{
    if (imageCache == nil) {
        imageCache = [[NSMutableDictionary alloc] init];
    }

    [imageCache setObject:image forKey:key];
}

- (void)imageWithURL:(NSString *)url placeholderImage:(UIImage *)placeholde  completed:(void(^)(NSString *info,UIImage *image))completedBlock
{
    
    NSString *name = url;
    BOOL cache = YES;
    NSString *httpStr = @"http://";
    
    if ([name hasPrefix:httpStr]) {
        NSMutableString *mutableStr = [NSMutableString stringWithString:name];
        [mutableStr deleteCharactersInRange:NSMakeRange(0, 7)];
        name = [NSString stringWithString:mutableStr];
    }
    
    if (placeholde) {
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            self.image = placeholde;
        });
    }
   
    UIImage *cacheImage = [imageCache objectForKey:[NSString stringWithFormat:@"%@", name]];
    if (cacheImage) {
        //通知主线程刷新
        dispatch_async(dispatch_get_main_queue(), ^{
            //内存中有直接返回
            self.image = cacheImage;
        });
        completedBlock(@"内存加载",cacheImage);
        return;
    }
    
    if (cache) {
        //从文件缓存中读取
        NSFileManager *manager = [NSFileManager defaultManager];
        NSString *pngFilePath = [[ALDImageDownloadManager sharedManager] getFilePath:name];
        if (pngFilePath && [manager fileExistsAtPath:pngFilePath]) {
            UIImage *image = [UIImage imageWithContentsOfFile:pngFilePath];
            if (image) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = image;
                    //加载到内存
                    [self saveToImageCache:image byKey:[NSString stringWithFormat:@"%@", name]];
                });
                completedBlock(@"硬盘缓存",image);
                
                return;
            }
        }
    }
    [self downloadImage:name cache:cache completed:completedBlock];
}

@end
