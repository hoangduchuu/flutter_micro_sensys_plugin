
import 'micro_sensys_platform_interface.dart';

class MicroSensys {
  Future<String?> getPlatformVersion() {
    return MicroSensysPlatform.instance.getPlatformVersion();
  }

  Future<bool?> initReader() {
    return MicroSensysPlatform.instance.initReader();
  }
  Future<String?> identifyTag() {
    return MicroSensysPlatform.instance.identifyTag();
  }
}
