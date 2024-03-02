
import 'micro_sensys_platform_interface.dart';

class MicroSensys {
  Future<String?> getPlatformVersion() {
    return MicroSensysPlatform.instance.getPlatformVersion();
  }
}
