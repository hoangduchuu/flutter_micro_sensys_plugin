import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'micro_sensys_platform_interface.dart';

/// An implementation of [MicroSensysPlatform] that uses method channels.
class MethodChannelMicroSensys extends MicroSensysPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('micro_sensys');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
