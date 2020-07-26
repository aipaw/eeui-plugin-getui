//
//  eeuiGetuiDelegate.h
//  Pods
//

#import <GTSDK/GeTuiSdk.h>     // GetuiSdk头文件应用

// iOS10 及以上需导入 UserNotifications.framework
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif

@interface eeuiGetuiDelegate : NSObject

- (id)init;

- (void) startSdkWithAppId;

@end
