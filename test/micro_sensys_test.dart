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

  @override
  Future<bool?> checkConnected() {
    // TODO: implement checkConnected
    throw UnimplementedError();
  }

  @override
  Future<bool?> checkConnecting() {
    // TODO: implement checkConnecting
    throw UnimplementedError();
  }

  @override
  Future<bool?> checkInitialized() {
    // TODO: implement checkInitialized
    throw UnimplementedError();
  }

  @override
  Future<void> disConnect() {
    // TODO: implement disConnect
    throw UnimplementedError();
  }

  @override
  Future<String?> identifyTag() {
    // TODO: implement identifyTag
    throw UnimplementedError();
  }

  @override
  Future<bool?> initIOSReader({required String deviceName}) {
    // TODO: implement initIOSReader
    throw UnimplementedError();
  }

  @override
  Future<bool?> initReader({String? frequencyType, String? communicationType}) {
    // TODO: implement initReader
    throw UnimplementedError();
  }

  @override
  Stream<String> iosListenStatus() {
    // TODO: implement iosListenStatus
    throw UnimplementedError();
  }

  @override
  Stream<String> listenTags() {
    // TODO: implement listenTags
    throw UnimplementedError();
  }
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
