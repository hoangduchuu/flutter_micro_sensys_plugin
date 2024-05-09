import Flutter
import UIKit
import microsensys_lib


public class MicroSensysPlugin: NSObject, FlutterPlugin, ShowConnectedDeviceInformationCallback,ShowDeviceBatteryStatusCallback,ShowStatusMessageCallback,ShowResponseMessageCallback {
    

    var isIntialized = false;
    var streamHandler: MyStreamHandler?


 
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "micro_sensys", binaryMessenger: registrar.messenger())
    let instance = MicroSensysPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
      
      // stream event
      
      // Initialize MyStreamHandler and set it as the stream handler
         instance.streamHandler = MyStreamHandler()
         let eventChannel = FlutterEventChannel(name: "micro_sensys_events", binaryMessenger: registrar.messenger())
         eventChannel.setStreamHandler(instance.streamHandler)

  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
        var customTitle: String = "Micro-Sensys GmbH\nIn der Hochstedter Ecke 2\n99098 Erfurt\n\nLibrary Version: \(microsensys_lib.microsensys_libVersionNumber)"
      result("iOSa: " + customTitle)
    case "initReader":
        initReader(result: result)
    case "initIOSReader":
        initIosReader(call:call,result:result)
    case "disConnect":
        BleRfidLib.shared.DisconnectDevice()
    case"identifyTag":
        identifyTag(result: result)
    case"checkConnected":
        debugPrint("MicroSensysPlugin: checkConnected")
        streamHandler?.eventSink?("SHOWDEVICE-checkConnected")
    case"showDevices":
        showDevice()
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    
    public func identifyTag(result: FlutterResult){
        DispatchQueue.main.async {
            debugPrint("MicroSensysPlugin: identifyTag")
            BleRfidLib.shared.Identify(info: AntennaInfo.Antenna_Info_On)
        }
    }

    public func showDevice(){
        streamHandler?.eventSink?("SHOWDEVICE")
    }
    
    public func disConnect(){
        
    }
    
    // Method to initialize reader and set up callbacks
       public func initReader(result: FlutterResult) {
           
           debugPrint("MicroSensysPlugin: initReader")
    
       }
    
    public func initIosReader(call: FlutterMethodCall,result: FlutterResult){
        let myresult = call.arguments as? [String: Any]

        debugPrint("MicroSensysPlugin: initIosReader")

        if let deviceName = myresult?["deviceName"] as? String {
            // `deviceName` is a non-optional String here
            print("DeviceName: \(deviceName)")
               if(!isIntialized){
                   debugPrint("initReader-----")
                   BleRfidLib.shared.InitShowConnectedDeviceInformationCallback(delegate: self)
                   // Initialize other callbacks
                   BleRfidLib.shared.InitShowDeviceBatteryStatusCallback(delegate: self)
                   BleRfidLib.shared.InitShowStatusMessageCallback(delegate: self)
                   BleRfidLib.shared.InitShowResponseMessageCallback(delegate: self)
                   
                   // Additional initialization code can go here...
                   do{
                       sleep(1)
                   }
               }else{
                   debugPrint("INTIALIZED: else cáe-----")
               }
               isIntialized = true;

               debugPrint("CONNECT----!-")
               BleRfidLib.shared.ConnectDeviceByName(deviceName: deviceName)
        } else {
            // Handle the case where `deviceName` is nil
            print("DeviceName not found or is nil")
        }
    }

       // Implement the callback method
       public func ShowConnectedDeviceInformation(info: [String : String]) {
           // Handle connected device information here
           // For example, you can log the information or pass it back to the Flutter app
           debugPrint("MicroSensysPlugin: Connected Device Info: \(info)")

       }

       // Implement other callback methods similarly
       public func ShowDeviceBatteryStatus(status: String) {
           // Handle device battery status here
           debugPrint("MicroSensysPlugin: Device Battery Status:: \(status)")

       }

       public func ShowStatusMessage(status: String) {
           // Handle status message here
           debugPrint("MicroSensysPlugin: Status Message: \(status)")

       }

       public func ShowResponseMessage(data: [String]) {
           // Handle response message here
           debugPrint("MicroSensysPlugin: Response Message: \(data)")
           streamHandler?.eventSink?(data[0].uppercased())
       }
    

       // Method call handling and other plugin code...
    
    //endregion
}

//region handler

public class MyStreamHandler: NSObject,FlutterStreamHandler{
var eventSink: FlutterEventSink?
        
        // Implement the onListen method
    public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
    
            self.eventSink = events
            // Example: Send a sample event
            events("MicroSensysPlugin: Registered")
            // Return nil if no error
            return nil
        }
        
        // Implement the onCancel method
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
            // Stop emitting events here
            self.eventSink = nil
            
            // Return nil if no error
            return nil
        }
}


//endregion handler
