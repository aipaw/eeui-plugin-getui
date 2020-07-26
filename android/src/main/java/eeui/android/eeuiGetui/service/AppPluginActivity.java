package eeui.android.eeuiGetui.service;

import android.app.Activity;
import android.os.Bundle;
import com.igexin.sdk.GTServiceManager;

public class AppPluginActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        GTServiceManager.getInstance().onActivityCreate(this);
    }
}
