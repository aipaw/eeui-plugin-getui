package eeui.android.eeuiGetui.service;

import android.app.Activity;
import android.content.Context;

import com.alibaba.fastjson.JSONObject;
import com.igexin.sdk.GTIntentService;
import com.igexin.sdk.message.GTCmdMessage;
import com.igexin.sdk.message.GTNotificationMessage;
import com.igexin.sdk.message.GTTransmitMessage;

import java.util.LinkedList;

import app.eeui.framework.activity.PageActivity;
import app.eeui.framework.extend.bean.PageStatus;
import app.eeui.framework.ui.eeui;

/**
 * 继承 GTIntentService 接收来自个推的消息, 所有消息在线程中回调<br>
 * onReceiveMessageData 处理透传消息<br>
 * onReceiveClientId 接收 cid <br>
 * onReceiveOnlineState cid 离线上线通知 <br>
 * onReceiveCommandResult 各种事件处理回执 <br>
 */
public class PushIntentService extends GTIntentService {

    public PushIntentService() {
    }

    private void postMessage(JSONObject message)
    {
        LinkedList<Activity> activityList = eeui.getActivityList();
        for (Activity mContext : activityList) {
            if (mContext instanceof PageActivity) {
                ((PageActivity) mContext).onAppStatusListener(new PageStatus("page", "message", null, message));
            }
        }
    }

    @Override
    public void onReceiveServicePid(Context context, int pid) {
        // Log.d("GetuiLogger", "onReceiveServicePid = " +  pid);
    }

    @Override
    public void onReceiveClientId(Context context, String clientId) {
        // Log.d("GetuiLogger", "onReceiveClientId = " + clientId);

        JSONObject param = new JSONObject();
        param.put("messageType", "getui");
        param.put("getuiType", "cid");
        param.put("cid", clientId);
        postMessage(param);
    }

    @Override
    public void onReceiveMessageData(Context context, GTTransmitMessage msg) {
        String message = new String(msg.getPayload());
        // Log.d("GetuiLogger", "onReceiveMessageData msg = " + message);

        JSONObject param = new JSONObject();
        param.put("messageType", "getui");
        param.put("getuiType", "payload");
        param.put("payload", message);
        postMessage(param);
    }

    @Override
    public void onReceiveOnlineState(Context context, boolean online) {
        // Log.d("GetuiLogger", "onReceiveOnlineState online = " + online);

        JSONObject param = new JSONObject();
        param.put("messageType", "getui");
        param.put("getuiType", "state");
        param.put("state", online ? 1 : 0);
        postMessage(param);
    }

    @Override
    public void onReceiveCommandResult(Context context, GTCmdMessage cmdMessage) {
        // Log.d("GetuiLogger", "onReceiveCommandResult cmdMessage action = " + cmdMessage.getAction());
    }


    // 通知到达
    @Override
    public void onNotificationMessageArrived(Context context, GTNotificationMessage message) {
        /*Log.d("GetuiLogger", "onNotificationMessageArrived -> " + "appid = " + message.getAppid() + "\ntaskid = " + message.getTaskId() + "\nmessageid = "
                + message.getMessageId() + "\npkg = " + message.getPkgName() + "\ncid = " + message.getClientId() + "\ntitle = "
                + message.getTitle() + "\ncontent = " + message.getContent());*/

        JSONObject param = new JSONObject();
        param.put("messageType", "getui");
        param.put("getuiType", "notificationArrived");
        param.put("taskId", message.getTaskId());
        param.put("messageId", message.getMessageId());
        param.put("title", message.getTitle());
        param.put("content", message.getContent());
        postMessage(param);
    }

    // 点击回调
    @Override
    public void onNotificationMessageClicked(Context context, GTNotificationMessage message) {
        /*Log.d("GetuiLogger", "onNotificationMessageClicked -> " + "appid = " + message.getAppid() + "\ntaskid = " + message.getTaskId() + "\nmessageid = "
                + message.getMessageId() + "\npkg = " + message.getPkgName() + "\ncid = " + message.getClientId() + "\ntitle = "
                + message.getTitle() + "\ncontent = " + message.getContent());*/

        JSONObject param = new JSONObject();
        param.put("messageType", "getui");
        param.put("getuiType", "notificationClicked");
        param.put("taskId",message.getTaskId());
        param.put("messageId",message.getMessageId());
        param.put("title",message.getTitle());
        param.put("content",message.getContent());
        postMessage(param);
    }
}