package eeui.android.eeuiGetui.module;

import com.alibaba.fastjson.JSONArray;
import com.igexin.sdk.PushManager;
import com.igexin.sdk.Tag;
import com.taobao.weex.annotation.JSMethod;
import com.taobao.weex.bridge.JSCallback;

import app.eeui.framework.extend.base.WXModuleBase;
import app.eeui.framework.ui.eeui;

public class eeuiGetuiAppModule extends WXModuleBase {

    /**
     * Android 不存在 destroy方法，仅停止推送服务
     */
    @JSMethod
    public void destroy(){
        PushManager.getInstance().turnOffPush(eeui.getApplication());
    }

    /**
     * 停止SDK服务
     */
    @JSMethod
    public void stop(){
        PushManager.getInstance().turnOffPush(eeui.getApplication());
    }

    /**
     * 恢复SDK运行，重新接收推送
     */
    @JSMethod
    public void resume(){
        PushManager.getInstance().turnOnPush(eeui.getApplication());
    }

    /**
     * 打开SDK的推送.
     */
    @JSMethod
    public void turnOnPush(){
        PushManager.getInstance().turnOnPush(eeui.getApplication());
    }

    /**
     * 关闭SDK的推送.
     */
    @JSMethod
    public void turnOffPush(){
        PushManager.getInstance().turnOffPush(eeui.getApplication());
    }

    /**
     * 获取SDK的Cid
     *
     * @return Cid值
     */
    @JSMethod(uiThread = false)
    public String clientId(){
        return PushManager.getInstance().getClientid(eeui.getApplication());
    }

    /**
     * 获取SDK运行状态,
     *
     * @return 运行状态 1为已开启推送，0为已停止推送
     */
    @JSMethod(uiThread = false)
    public int status(){
        boolean isPushTurnOn = PushManager.getInstance().isPushTurnedOn(eeui.getApplication());
        return isPushTurnOn ? 1 : 0;
    }

    /**
     * 获取SDK版本号
     *
     * @return 版本号
     */
    @JSMethod(uiThread = false)
    public String version(){
        return PushManager.getInstance().getVersion(eeui.getApplication());
    }

    /**
     * 是否允许SDK 后台运行(默认为true)
     * 该方法在Android中无效，仅在iOS有效
     * @param isEnable
     */
    @JSMethod
    public void runBackgroundEnable(boolean isEnable){
        // Empty
    }

    /**
     * 地理围栏功能，设置地理围栏是否运行
     * 该方法在Android中无效，仅在iOS有效，在AndroidManifest.xml开启相应地权限
     * <uses-permission android:name="android.permission.ACCESS_FINE_LOCATION" />
     * <uses-permission android:name="android.permission.ACCESS_COARSE_LOCATION" />
     * @param isEnable 设置地理围栏功能是否运行（默认值：NO）
     * @param isVerify 设置是否SDK主动弹出用户定位请求（默认值：NO）
     */
    @JSMethod
    public void lbsLocationEnable(boolean isEnable, boolean isVerify){
        // Empty
    }

    /**
     *  设置渠道
     *  该方法在Android中无效，仅在iOS有效Ø
     *  @param channelId 渠道值，可以为空值
     */
    @JSMethod
    public void setChannelId(String channelId){
        // Empty
    }

    /**
     * 向个推服务器注册DeviceToken
     * 该方法在Android中无效，仅在iOS有效
     * @param deviceToken
     */
    @JSMethod
    public void registerDeviceToken(String deviceToken){
        // Empty

    }

    /**
     * 绑定别名功能:后台可以根据别名进行推送
     *
     * @param alias 别名字符串
     * @param aSn   绑定序列码, Android中无效，仅在iOS有效
     */
    @JSMethod
    public void bindAlias(String alias, String aSn){
        PushManager.getInstance().bindAlias(eeui.getApplication(), alias);
    }

    /**
     *  取消绑定别名功能
     *
     *  @param alias 别名字符串
     *  @param aSn   绑定序列码, Android中无效，仅在iOS有效
     */
    @JSMethod
    public void unbindAlias(String alias, String aSn){
        PushManager.getInstance().unBindAlias(eeui.getApplication(), alias, false);
    }

    /**
     *  给用户打标签 , 后台可以根据标签进行推送
     *
     *  @param tags 别名数组
     */
    @JSMethod
    public void setTag(JSONArray tags){
        if (tags == null || tags.size() == 0){
            return;
        }

        Tag[] tagArray = new Tag[tags.size()];
        for (int i = 0; i < tags.size(); i++ ){
            Tag tag = new Tag();
            tag.setName(tags.getString(i));
            tagArray[i] = tag;
        }

        PushManager.getInstance().setTag(eeui.getApplication(), tagArray, "setTag");
    }

    /**
     * 设置关闭推送模式
     * Android中无效，仅在iOS有效
     *
     * @param isValue
     */
    @JSMethod
    public void setPushModeForOff(boolean isValue){
        // Empty
    }

    /**
     * 同步角标值到个推服务器
     * Android中无效，仅在iOS有效
     * @param value
     */
    @JSMethod
    public void setBadge(int value){
        // Empty
    }

    /**
     * 重置角标值到个推服务器
     * Android中无效，仅在iOS有效
     * @param badge
     */
    @JSMethod
    public void resetBadge(int badge){
        //Empty
    }


    /**
     *  SDK发送上行消息结果
     *  Android中无效，仅在iOS有效
     *  @param body  需要发送的消息数据
     *  @param error 如果发送成功返回messageid
     *
     */
    @JSMethod
    public void sendMessage(String body, String error){
        // Empty

    }

    /**
     *  上行第三方自定义回执actionid
     *  @param actionId 用户自定义的actionid，int类型，取值90001-90999。
     *  @param taskId   下发任务的任务ID
     *  @param msgId    下发任务的消息ID
     *
     *  @return 上行成功或失败，若上行失败，可能上行失败；taskid为空或者 messageid 为空 或者 actionid 不在取值范围以内
     */
    @JSMethod
    public void sendFeedbackMessage(int actionId, String taskId, String msgId, JSCallback callback){
        callback.invoke(PushManager.getInstance().sendFeedbackMessage(eeui.getApplication(), taskId, msgId, actionId));
    }

    /**
     * 设置静默时间
     *
     * @param beginHour 开始时间，设置范围在0-23小时之间，单位 h
     * @param duration 持续时间，设置范围在0-23小时之间。持续时间为0则不静默，单位 h
     */
    @JSMethod
    public void sendSilentTime(int beginHour, int duration, JSCallback callback){
        callback.invoke(PushManager.getInstance().setSilentTime(eeui.getApplication(), beginHour, duration));
    }

    /**
     * 设置Socket超时时间
     * @param times 超时时间
     */
    @JSMethod
    public void setSocketTimeout(int times){
        PushManager.getInstance().setSocketTimeout(eeui.getApplication(), times);
    }
}
