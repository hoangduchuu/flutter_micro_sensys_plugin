import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'micro_sensys_platform_interface.dart';

/// An implementation of [MicroSensysPlatform] that uses method channels.
class MethodChannelMicroSensys extends MicroSensysPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('micro_sensys');

  final EventChannel eventChannel = const EventChannel('micro_sensys_events');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }


  Future<bool?> initReader({ String? frequencyType, String? communicationType}) {
    var params = {
      'frequencyType': frequencyType ?? 'UHF',
      'communicationType': communicationType ?? 'BLE',
    };
    return methodChannel.invokeMethod<bool>('initReader', params);
  }

  Future<bool?> initIOSReader({required String deviceName}) {
    return methodChannel.invokeMethod<bool>('initIOSReader', {'deviceName': deviceName});
  }

  Future<String?> identifyTag() {
    return methodChannel.invokeMethod<String?>('identifyTag');
  }

  Future<bool?> checkConnected() {
    return methodChannel.invokeMethod<bool>('checkConnected');
  }

  Future<bool?> checkInitialized() {
    return methodChannel.invokeMethod<bool>('checkInitialized');
  }

  Future<void> disConnect() {
    return methodChannel.invokeMethod<void>('disConnect');
  }

  Stream<String> listenTags() {
    return eventChannel.receiveBroadcastStream().cast<String>();
  }
}
