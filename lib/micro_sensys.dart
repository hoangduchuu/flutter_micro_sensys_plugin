import 'micro_sensys_platform_interface.dart';

class MicroSensys {
  Future<String?> getPlatformVersion() {
    return MicroSensysPlatform.instance.getPlatformVersion();
  }

  Future<bool?> initReader({ String? frequencyType, String? communicationType}) {
    return MicroSensysPlatform.instance.initReader(frequencyType: frequencyType, communicationType: communicationType);
  }

  Future<bool?> initIOSReader({required String deviceName}) {
    return MicroSensysPlatform.instance.initIOSReader(deviceName: deviceName);
  }

  Future<String?> identifyTag() {
    return MicroSensysPlatform.instance.identifyTag();
  }

  Future<bool?> checkConnected() {
    return MicroSensysPlatform.instance.checkConnected();
  }

  Future<bool?> checkInitialized() {
    return MicroSensysPlatform.instance.checkInitialized();
  }

  Future disConnect() {
    return MicroSensysPlatform.instance.disConnect();
  }

  Stream<String> listenTags() {
    return MicroSensysPlatform.instance.listenTags();
  }
}
