import Flutter
import UIKit
import microsensys_lib


class MyStreamHandler :NSObject, FlutterStreamHandler {
    var eventSink: FlutterEventSink?
    var mF: FlutterResult
    
}
