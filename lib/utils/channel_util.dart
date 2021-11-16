
import 'package:flutter/services.dart';

import 'device_util.dart';

class ChannelUtil {
  static const MethodChannel _kChannel = MethodChannel('jrytop.catrun/methodchannel');

  static Future<String> getChannel() async {
    if (DeviceUtil.isAndroid) {
      var result = await _kChannel.invokeMethod('getChannel');
      return result;
    } else if (DeviceUtil.isIOS) {
      return 'iOS';
    }
    return 'unknown';
  }
}