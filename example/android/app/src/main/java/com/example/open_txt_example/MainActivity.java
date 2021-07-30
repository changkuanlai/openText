package com.example.open_txt_example;

import androidx.annotation.NonNull;

import com.bifan.txtreaderlib.ui.HwTxtPlayActivity;

import java.util.Map;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "com.disk.native.receive/open_txt";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        MethodChannel methodChannel = new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL);
        // 1.创建MethodChannel对象
        methodChannel.setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("openTxt")) {
                        final Map<String,String> map = (Map<String, String>) call.arguments;
                        HwTxtPlayActivity.loadTxtFile(this, map.get("patch"));
                    }else {
                        result.notImplemented();
                    }
                }
        );

    }
    
}
