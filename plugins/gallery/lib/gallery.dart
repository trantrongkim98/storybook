
import 'dart:async';

import 'package:flutter/services.dart';

class Gallery {
  static const MethodChannel _channel =
      const MethodChannel('gallery');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}
