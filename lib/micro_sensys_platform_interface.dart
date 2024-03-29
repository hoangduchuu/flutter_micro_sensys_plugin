import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'micro_sensys_method_channel.dart';

abstract class MicroSensysPlatform extends PlatformInterface {
  /// Constructs a MicroSensysPlatform.
  MicroSensysPlatform() : super(token: _token);

  static final Object _token = Object();

  static MicroSensysPlatform _instance = MethodChannelMicroSensys();

  /// The default instance of [MicroSensysPlatform] to use.
  ///
  /// Defaults to [MethodChannelMicroSensys].
  static MicroSensysPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MicroSensysPlatform] when
  /// they register themselves.
  static set instance(MicroSensysPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
