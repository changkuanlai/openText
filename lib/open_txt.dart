import 'dart:async';

import 'package:flutter/services.dart';

class OpenTxt {
  //获取插件与原生Native的交互通道
  static const _sendToNative =
      const MethodChannel('com.disk.native.receive/open_txt');

  // 发送原生打开txt指令
  static Future<Null> sendDataToNative(String filePath) async {
    Map<String, String> map = {"patch": filePath};
    String result = await _sendToNative.invokeMethod('openTxt', map);
    print(result);
  }
}
