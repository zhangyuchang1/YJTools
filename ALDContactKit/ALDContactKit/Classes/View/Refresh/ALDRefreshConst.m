//  代码地址: https://github.com/CoderMJLee/ALDRefresh
//  代码地址: http://code4app.com/ios/%E5%BF%AB%E9%80%9F%E9%9B%86%E6%88%90%E4%B8%8B%E6%8B%89%E4%B8%8A%E6%8B%89%E5%88%B7%E6%96%B0/52326ce26803fabc46000000
#import <UIKit/UIKit.h>

const CGFloat ALDRefreshHeaderHeight = 54.0;
const CGFloat ALDRefreshFooterHeight = 44.0;
const CGFloat ALDRefreshFastAnimationDuration = 0.25;
const CGFloat ALDRefreshSlowAnimationDuration = 0.4;

NSString *const ALDRefreshKeyPathContentOffset = @"contentOffset";
NSString *const ALDRefreshKeyPathContentInset = @"contentInset";
NSString *const ALDRefreshKeyPathContentSize = @"contentSize";
NSString *const ALDRefreshKeyPathPanState = @"state";

NSString *const ALDRefreshHeaderLastUpdatedTimeKey = @"ALDRefreshHeaderLastUpdatedTimeKey";

NSString *const ALDRefreshHeaderIdleText = @"下拉可以刷新";
NSString *const ALDRefreshHeaderPullingText = @"松开立即刷新";
NSString *const ALDRefreshHeaderRefreshingText = @"正在刷新数据中...";

NSString *const ALDRefreshAutoFooterIdleText = @"点击或上拉加载更多";
NSString *const ALDRefreshAutoFooterRefreshingText = @"正在加载更多的数据...";
NSString *const ALDRefreshAutoFooterNoMoreDataText = @"已经全部加载完毕";

NSString *const ALDRefreshBackFooterIdleText = @"上拉可以加载更多";
NSString *const ALDRefreshBackFooterPullingText = @"松开立即加载更多";
NSString *const ALDRefreshBackFooterRefreshingText = @"正在加载更多的数据...";
NSString *const ALDRefreshBackFooterNoMoreDataText = @"已经全部加载完毕";