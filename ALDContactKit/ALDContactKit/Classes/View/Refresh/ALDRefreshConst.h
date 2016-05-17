//  代码地址: https://github.com/CoderMJLee/ALDRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
#import <UIKit/UIKit.h>
#import <objc/message.h>

// 日志输出
#ifdef DEBUG
#define ALDRefreshLog(...) NSLog(__VA_ARGS__)
#else
#define ALDRefreshLog(...)
#endif

// 过期提醒
#define ALDRefreshDeprecated(instead) NS_DEPRECATED(2_0, 2_0, 2_0, 2_0, instead)

// 运行时objc_ALDRefreshMsgSend
#define ALDRefreshMsgSend(...) ((void (*)(void *, SEL, UIView *))objc_msgSend)(__VA_ARGS__)
#define ALDRefreshMsgTarget(target) (__bridge void *)(target)

// RGB颜色
#define ALDRefreshColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

// 文字颜色
#define ALDRefreshLabelTextColor ALDRefreshColor(90, 90, 90)

// 字体大小
#define ALDRefreshLabelFont [UIFont boldSystemFontOfSize:14]

// 图片路径
#define ALDRefreshSrcName(file) [@"ALDRefresh.bundle" stringByAppendingPathComponent:file]
#define ALDRefreshFrameworkSrcName(file) [@"Frameworks/ALDRefresh.framework/ALDRefresh.bundle" stringByAppendingPathComponent:file]

// 常量
UIKIT_EXTERN const CGFloat ALDRefreshHeaderHeight;
UIKIT_EXTERN const CGFloat ALDRefreshFooterHeight;
UIKIT_EXTERN const CGFloat ALDRefreshFastAnimationDuration;
UIKIT_EXTERN const CGFloat ALDRefreshSlowAnimationDuration;

UIKIT_EXTERN NSString *const ALDRefreshKeyPathContentOffset;
UIKIT_EXTERN NSString *const ALDRefreshKeyPathContentSize;
UIKIT_EXTERN NSString *const ALDRefreshKeyPathContentInset;
UIKIT_EXTERN NSString *const ALDRefreshKeyPathPanState;

UIKIT_EXTERN NSString *const ALDRefreshHeaderLastUpdatedTimeKey;

UIKIT_EXTERN NSString *const ALDRefreshHeaderIdleText;
UIKIT_EXTERN NSString *const ALDRefreshHeaderPullingText;
UIKIT_EXTERN NSString *const ALDRefreshHeaderRefreshingText;

UIKIT_EXTERN NSString *const ALDRefreshAutoFooterIdleText;
UIKIT_EXTERN NSString *const ALDRefreshAutoFooterRefreshingText;
UIKIT_EXTERN NSString *const ALDRefreshAutoFooterNoMoreDataText;

UIKIT_EXTERN NSString *const ALDRefreshBackFooterIdleText;
UIKIT_EXTERN NSString *const ALDRefreshBackFooterPullingText;
UIKIT_EXTERN NSString *const ALDRefreshBackFooterRefreshingText;
UIKIT_EXTERN NSString *const ALDRefreshBackFooterNoMoreDataText;

// 状态检查
#define ALDRefreshCheckState \
ALDRefreshState oldState = self.state; \
if (state == oldState) return; \
[super setState:state];
