import 'package:flutter_test/flutter_test.dart';
import 'package:micro_sensys/micro_sensys.dart';
import 'package:micro_sensys/micro_sensys_platform_interface.dart';
import 'package:micro_sensys/micro_sensys_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMicroSensysPlatform
    with MockPlatformInterfaceMixin
    implements MicroSensysPlatform {
  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final MicroSensysPlatform initialPlatform = MicroSensysPlatform.instance;

  test('$MethodChannelMicroSensys is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMicroSensys>());
  });

  test('getPlatformVersion', () async {
    MicroSensys microSensysPlugin = MicroSensys();
    MockMicroSensysPlatform fakePlatform = MockMicroSensysPlatform();
    MicroSensysPlatform.instance = fakePlatform;

    expect(await microSensysPlugin.getPlatformVersion(), '42');
  });
}
