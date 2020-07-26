//
//  eeuiGetuiAppModule.m
//  Pods
//

#import "eeuiGetuiAppModule.h"
#import <WeexPluginLoader/WeexPluginLoader.h>
#import <GTSDK/GeTuiSdk.h>

@interface eeuiGetuiAppModule ()

@end

@implementation eeuiGetuiAppModule

@synthesize weexInstance;

WX_PlUGIN_EXPORT_MODULE(eeuiGetui, eeuiGetuiAppModule)
WX_EXPORT_METHOD(@selector(destroy))
WX_EXPORT_METHOD(@selector(stop))
WX_EXPORT_METHOD(@selector(resume))
WX_EXPORT_METHOD(@selector(turnOnPush))
WX_EXPORT_METHOD(@selector(turnOffPush))
WX_EXPORT_METHOD_SYNC(@selector(clientId))
WX_EXPORT_METHOD_SYNC(@selector(status))
WX_EXPORT_METHOD_SYNC(@selector(version))
WX_EXPORT_METHOD(@selector(runBackgroundEnable:))
WX_EXPORT_METHOD(@selector(lbsLocationEnable:andUserVerify:))
WX_EXPORT_METHOD(@selector(setChannelId:))
WX_EXPORT_METHOD(@selector(registerDeviceToken:))
WX_EXPORT_METHOD(@selector(bindAlias:andSequenceNum:))
WX_EXPORT_METHOD(@selector(unbindAlias:andSequenceNum:))
WX_EXPORT_METHOD(@selector(setTag:))
WX_EXPORT_METHOD(@selector(setPushModeForOff:))
WX_EXPORT_METHOD(@selector(setBadge:))
WX_EXPORT_METHOD(@selector(resetBadge))
WX_EXPORT_METHOD(@selector(sendMessage:error:))
WX_EXPORT_METHOD(@selector(sendFeedbackMessage:andTaskId:andMsgId:callback:))

/**
 *  销毁SDK，并且释放资源
 */

- (void)destroy {
    [GeTuiSdk destroy];
}

- (void)stop {
    [GeTuiSdk destroy];
}

/**
 *  恢复SDK运行,IOS7 以后支持Background Fetch方式，后台定期更新数据,该接口需要在Fetch起来后被调用，保证SDK 数据获取。
 */

- (void)resume {
    [GeTuiSdk resume];
}

/**
*   开启推送.
*/
- (void)turnOnPush {
    [GeTuiSdk setPushModeForOff:NO];
}

/**
*   关闭推送.
*/
- (void)turnOffPush {
    [GeTuiSdk setPushModeForOff:YES];
}

/**
 *  获取SDK的Cid
 *
 *  @return Cid值
 */
- (NSString *)clientId {
    return [GeTuiSdk clientId] ?: @"";
}

/**
 *  获取SDK运行状态
 *
 *  @return 运行状态
 */
- (int)status {
    return [GeTuiSdk status] == SdkStatusStarted ? 1 : 0;
}

/**
 *  获取SDK版本号
 *
 *  @return 版本值
 */
- (NSString *)version {
    return [GeTuiSdk version];
}

#pragma mark -

/**
 *  是否允许SDK 后台运行（默认值：NO）
 *  备注：可以未启动SDK就调用该方法
 *  警告：该功能会和音乐播放冲突，使用时请注意
 *
 *  @param isEnable 支持当APP进入后台后，个推是否运行,YES.允许
 */
- (void)runBackgroundEnable:(BOOL)isEnable {
    [GeTuiSdk runBackgroundEnable:isEnable];
}

/**
 *  地理围栏功能，设置地理围栏是否运行
 *  备注：SDK可以未启动就调用该方法
 *
 *  @param isEnable 设置地理围栏功能是否运行（默认值：NO）
 *  @param isVerify 设置是否SDK主动弹出用户定位请求（默认值：NO）
 */
- (void)lbsLocationEnable:(BOOL)isEnable andUserVerify:(BOOL)isVerify {
    [GeTuiSdk lbsLocationEnable:isEnable andUserVerify:isVerify];
}

#pragma mark -

/**
 *  设置渠道
 *  备注：SDK可以未启动就调用该方法
 *
 *  SDK-1.5.0+
 *
 *  @param aChannelId 渠道值，可以为空值
 */


- (void)setChannelId:(NSString *)aChannelId {
    [GeTuiSdk setChannelId:aChannelId];
}

/**
 *  向个推服务器注册DeviceToken
 *  备注：可以未启动SDK就调用该方法
 *
 *  @param deviceToken 推送时使用的deviceToken
 *
 */
- (void)registerDeviceToken:(NSString *)deviceToken {
    [GeTuiSdk registerDeviceToken:deviceToken];
}

/**
 *  绑定别名功能:后台可以根据别名进行推送
 *
 *  @param alias 别名字符串
 *  @param aSn   绑定序列码, 不为nil
 */
- (void)bindAlias:(NSString *)alias andSequenceNum:(NSString *)aSn {
    [GeTuiSdk bindAlias:alias andSequenceNum:aSn];
}

/**
 *  取消绑定别名功能
 *
 *  @param alias 别名字符串
 *  @param aSn   绑定序列码, 不为nil
 */
- (void)unbindAlias:(NSString *)alias andSequenceNum:(NSString *)aSn {
    [GeTuiSdk unbindAlias:alias andSequenceNum:aSn andIsSelf:YES];
}

/**
 *  给用户打标签 , 后台可以根据标签进行推送
 *
 *  @param tags 别名数组
 *
 *  @return 提交结果，YES表示尝试提交成功，NO表示尝试提交失败
 */
- (void)setTag:(NSArray *)tags {
    [GeTuiSdk setTags:tags];
}

/**
 *  设置关闭推送模式（默认值：NO）
 *
 *  @param isValue 消息推送开发，YES.关闭消息推送 NO.开启消息推送
 *
 *  SDK-1.2.1+
 *
 */
- (void)setPushModeForOff:(BOOL)isValue {
    [GeTuiSdk setPushModeForOff:isValue];
}


/**
 *  同步角标值到个推服务器
 *  该方法只是同步角标值到个推服务器，本地仍须调用setApplicationIconBadgeNumber函数
 *
 *  SDK-1.4.0+
 *
 *  @param value 角标数值
 */

- (void)setBadge:(NSUInteger)value {
    [GeTuiSdk setBadge:value];
}

- (void)resetBadge {
    [GeTuiSdk resetBadge];
}

#pragma mark -

/**
 *  SDK发送上行消息结果
 *
 *  @param body  需要发送的消息数据
 *  @param error 如果发送成功返回messageid，发送失败返回nil
 *
 *  @return 消息的msgId
 */
- (void)sendMessage:(NSData *)body error:(NSError **)error {
    [GeTuiSdk sendMessage:body error:error];
}

/**
 *  上行第三方自定义回执actionid
 *
 *  @param actionId 用户自定义的actionid，int类型，取值90001-90999。
 *  @param taskId   下发任务的任务ID
 *  @param msgId    下发任务的消息ID
 *
 *  @return BOOL，YES表示尝试提交成功，NO表示尝试提交失败。注：该结果不代表服务器收到该条数据
 *  该方法需要在回调方法“GeTuiSdkDidReceivePayload:andTaskId:andMessageId:andOffLine:fromApplication:”使用
 */
- (void)sendFeedbackMessage:(NSInteger)actionId andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId callback:(WXModuleCallback)callback {
    BOOL isSuccess = [GeTuiSdk sendFeedbackMessage:actionId andTaskId:taskId andMsgId:msgId];
    callback(@[isSuccess ? @"true" : @"false"]);
}

@end
