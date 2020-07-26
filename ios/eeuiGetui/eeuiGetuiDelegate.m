//
//  eeuiGetuiDelegate.m
//  Pods
//

#import "eeuiGetuiDelegate.h"
#import "eeuiNewPageManager.h"
#import "Config.h"

@interface eeuiGetuiDelegate () <GeTuiSdkDelegate, UNUserNotificationCenterDelegate>

@end

@implementation eeuiGetuiDelegate

- (id)init {
    self = [super init];
    return self;
}

- (void)startSdkWithAppId {
    NSDictionary *getuiConfig = [Config getObject:@"getui"];
    NSString *appId = [NSString stringWithFormat:@"%@", getuiConfig[@"GETUI_APP_ID"]];
    NSString *appKey = [NSString stringWithFormat:@"%@", getuiConfig[@"GETUI_APP_KEY"]];
    NSString *appSecret = [NSString stringWithFormat:@"%@", getuiConfig[@"GETUI_APP_SECRET"]];
    //
    if (appId.length > 0 && appKey.length > 0 && appSecret.length > 0) {
        [GeTuiSdk startSdkWithAppId:appId appKey:appKey appSecret:appSecret delegate:self];
        [self registerRemoteNotification];
    }
}


/**
 * [ 参考代码，开发者注意根据实际需求自行修改 ] 注册远程通知
 *
 * 警告：Xcode8及以上版本需要手动开启“TARGETS -> Capabilities -> Push Notifications”
 * 警告：该方法需要开发者自定义，以下代码根据APP支持的iOS系统不同，代码可以对应修改。以下为参考代码
 * 注意根据实际需要修改，注意测试支持的iOS系统都能获取到DeviceToken
 *
 */
- (void)registerRemoteNotification {
    if (@available(iOS 10.0, *)) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
            if (!error && granted) {
                NSLog(@"[ TestDemo ] iOS request authorization succeeded!");
            }
        }];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        return;
    }

    if (@available(iOS 8.0, *)) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
    }
}

#pragma mark - GeTuiSdkDelegate

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    // [4-EXT-1]: 个推SDK已注册，返回clientId
    // NSLog(@"\n>>[GTSdk RegisterClient]:%@\n\n", clientId);
    [[eeuiNewPageManager sharedIntstance] postMessage:@{
            @"messageType": @"getui",
            @"getuiType": @"cid",
            @"cid": clientId,
    }];
}

/** SDK遇到错误回调 */
- (void)GeTuiSdkDidOccurError:(NSError *)error {
    // [EXT]:个推错误报告，集成步骤发生的任何错误都在这里通知，如果集成后，无法正常收到消息，查看这里的通知。
    // NSLog(@"\n>>[GTSdk error]:%@\n\n", [error localizedDescription]);
}


/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    // [ GTSdk ]：汇报个推自定义事件(反馈透传消息)
    [GeTuiSdk sendFeedbackMessage:90001 andTaskId:taskId andMsgId:msgId];

    // 数据转换
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }

    //返回数据
    [[eeuiNewPageManager sharedIntstance] postMessage:@{
            @"messageType": @"getui",
            @"getuiType": @"payload",
            @"payload": @{@"taskId": taskId, @"msgId": msgId, @"payloadMsg": payloadMsg, @"offLine": offLine ? @"YES" : @"NO"},
    }];
}

/** SDK收到sendMessage消息回调 */
- (void)GeTuiSdkDidSendMessage:(NSString *)messageId result:(int)result {
    // 发送上行消息结果反馈
    // NSString *msg = [NSString stringWithFormat:@"sendmessage=%@,result=%d", messageId, result];
    // NSLog(@"\n>>[GTSdk DidSendMessage]:%@\n\n", msg);
}

/** SDK运行状态通知 */
- (void)GeTuiSDkDidNotifySdkState:(SdkStatus)aStatus {
    // 通知SDK运行状态
    // NSLog(@"\n>>[GTSdk SdkState]:%u\n\n", aStatus);
    [[eeuiNewPageManager sharedIntstance] postMessage:@{
            @"messageType": @"getui",
            @"getuiType": @"state",
            @"state": @(aStatus == SdkStatusStarted ? 1 : 0),
    }];
}

/** SDK设置推送模式回调 */
- (void)GeTuiSdkDidSetPushMode:(BOOL)isModeOff error:(NSError *)error {
    if (error) {
        // NSLog(@"\n>>[GTSdk SetModeOff Error]:%@\n\n", [error localizedDescription]);
        return;
    }
    // NSLog(@"\n>>[GTSdk SetModeOff]:%@\n\n", isModeOff ? @"开启" : @"关闭");
}


@end
