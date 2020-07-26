package eeui.android.eeuiGetui.entry;

import android.content.Context;

import com.igexin.sdk.PushManager;
import com.taobao.weex.WXSDKEngine;
import com.taobao.weex.common.WXException;

import app.eeui.framework.extend.annotation.ModuleEntry;
import eeui.android.eeuiGetui.module.eeuiGetuiAppModule;

@ModuleEntry
public class eeuiGetuiEntry {

    /**
     * APP启动会运行此函数方法
     * @param content Application
     */
    public void init(Context content) {
        PushManager.getInstance().initialize(content);

        //注册weex模块
        try {
            WXSDKEngine.registerModule("eeuiGetui", eeuiGetuiAppModule.class);
        } catch (WXException e) {
            e.printStackTrace();
        }
    }
}
