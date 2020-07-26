# 个推推送模块

## 安装

```shell script
eeui plugin install https://github.com/aipaw/eeui-plugin-getui
```

## 卸载

```shell script
eeui plugin uninstall https://github.com/aipaw/eeui-plugin-getui
```

## 引用

```js
const getui = app.requireModule("eeui/getui");
```

## 参数配置

`eeui.config.js`配置如下：

```js
module.exports = {
    //......
    getui: {
        GETUI_APP_ID    : "",
        GETUI_APP_KEY   : "",
        GETUI_APP_SECRET: "",
        XIAOMI_APP_ID   : "",
        XIAOMI_APP_KEY  : "",

        MEIZU_APP_ID    : "",
        MEIZU_APP_KEY   : "",

        HUAWEI_APP_ID   : "",

        OPPO_APP_KEY    : "",
        OPPO_APP_SECRET : "",

        VIVO_APP_ID     : "",
        VIVO_APP_KEY    : ""
    },
    //......
}
```

## 调用方法

```js
/**
 * 停止SDK服务
 */
getui.destroy();
getui.stop();

/**
 * 恢复SDK运行，重新接收推送
 */
getui.resume();

/**
 * 打开SDK的推送.
 */
getui.turnOnPush();

/**
 * 关闭SDK的推送.
 */
getui.turnOffPush();

/**
 * 获取SDK的Cid
 * @return Cid值
 */
let clientId = getui.clientId();

/**
 * 获取SDK运行状态,
 * @return 运行状态 1为已开启推送，0为已停止推送
 */
let status = getui.status();

/**
 * 获取SDK版本号
 * @return 版本号
 */
let version = getui.version();

/**
 * 是否允许SDK 后台运行(默认为true)
 * 该方法在Android中无效，仅在iOS有效
 * @param isEnable
 */
getui.runBackgroundEnable(isEnable);

/**
 * 地理围栏功能，设置地理围栏是否运行
 * 该方法在Android中无效，仅在iOS有效，在AndroidManifest.xml开启相应地权限
 * @param isEnable 设置地理围栏功能是否运行（默认值：NO）
 * @param isVerify 设置是否SDK主动弹出用户定位请求（默认值：NO）
 */
getui.lbsLocationEnable(isEnable,isVerify);

/**
 *  设置渠道
 *  该方法在Android中无效，仅在iOS有效Ø
 *  @param channelId 渠道值，可以为空值
 */
getui.setChannelId(channelId);

/**
 * 向个推服务器注册DeviceToken
 * 该方法在Android中无效，仅在iOS有效
 * @param deviceToken
 */
getui.registerDeviceToken(deviceToken);

/**
 * 绑定别名功能:后台可以根据别名进行推送
 * @param alias 别名字符串
 * @param aSn   绑定序列码, Android中无效，仅在iOS有效
 */
getui.bindAlias(alias,aSn);

/**
 *  取消绑定别名功能
 *  @param alias 别名字符串
 *  @param aSn   绑定序列码, Android中无效，仅在iOS有效
 */
getui.unbindAlias(alias,aSn);

/**
 *  给用户打标签 , 后台可以根据标签进行推送
 *  @param tags 别名数组
 */
getui.setTag(tags);

/**
 * 设置关闭推送模式
 * Android中无效，仅在iOS有效
 * @param isValue
 */
getui.setPushModeForOff(isValue);

/**
 * 同步角标值到个推服务器
 * Android中无效，仅在iOS有效
 * @param value
 */
getui.setBadge(value);

/**
 * 重置角标值到个推服务器
 * Android中无效，仅在iOS有效
 * @param badge
 */
getui.resetBadge();
```

## 推送消息

1.cid 拿到clientId的回调

2.payload透传消息回调

3.notificationArrived通知消息到达的回调

4.notificationClicked通知消息点击的回调

```html
<template>
    ...
</template>

<script>
    export default {
        pageMessage: function (data) {
            let msg = data.message;
            if (msg.messageType == 'getui') {
                //个推消息
                if (msg.getuiType == 'cid') {
                    console.log('初始化获取到cid：', msg.cid);
                } else if (msg.getuiType == 'payload') {
                    console.log('payload 消息通知：', msg.payload);
                } else if (msg.getuiType == 'notificationArrived') {
                    console.log('notificationArrived 通知到达：', msg);
                } else if (msg.getuiType == 'notificationClicked') {
                    console.log('notificationArrived 通知点击：', msg);
                }
            }
        }
    }
</script>
```
