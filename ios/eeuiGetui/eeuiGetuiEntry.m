//
//  eeuiGetuiEntry.m
//  Pods
//

#import "eeuiGetuiEntry.h"
#import "WeexInitManager.h"
#import "eeuiGetuiDelegate.h"
#import "eeuiNewPageManager.h"


WEEX_PLUGIN_INIT(eeuiGetuiEntry)
@implementation eeuiGetuiEntry

//启动成功
- (void) didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[[eeuiGetuiDelegate alloc] init] startSdkWithAppId];
}

//注册推送成功调用
- (void) didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    [GeTuiSdk registerDeviceTokenData:deviceToken];
}

// 注册推送失败调用
- (void) didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    
}

//iOS10以下使用这两个方法接收通知
- (void) didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [GeTuiSdk handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    //
    [[eeuiNewPageManager sharedIntstance] postMessage:@{
            @"messageType": @"getui",
            @"getuiType": @"notificationArrived",
            @"userInfo": userInfo,
    }];
}

//iOS10新增：处理前台收到通知的代理方法
- (void) willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler API_AVAILABLE(ios(10.0))
{
    completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
- (void) didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler API_AVAILABLE(ios(10.0))
{
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    completionHandler();
    //
    [[eeuiNewPageManager sharedIntstance] postMessage:@{
            @"messageType": @"getui",
            @"getuiType": @"notificationArrived",
            @"userInfo": response.notification.request.content.userInfo,
    }];
}

//捕捉回调
- (void) openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    
}

//捕捉握手
- (void) handleOpenURL:(NSURL *)url
{

}

//webView初始化
- (void) setJSCallModule:(JSCallCommon *)callCommon webView:(WKWebView*)webView
{
    
}
@end
