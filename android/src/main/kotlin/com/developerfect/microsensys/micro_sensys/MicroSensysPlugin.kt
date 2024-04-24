package com.developerfect.microsensys.micro_sensys

import android.content.Context
import androidx.annotation.NonNull
import de.microsensys.exceptions.MssException
import de.microsensys.functions.RFIDFunctions
import de.microsensys.utils.InterfaceTypeEnum
import de.microsensys.utils.PortTypeEnum
import de.microsensys.utils.ProtocolTypeEnum

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** MicroSensysPlugin */
class MicroSensysPlugin : FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel

    private lateinit var context: Context
    private var reader: RFIDFunctions? = null


    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "micro_sensys")
        context = flutterPluginBinding.applicationContext
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {

        when (call.method) {
            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE} - OK-")
            }
            "initReader" -> {
                initReader(result)
            }
            "identifyTag" -> {
                identifyTag(result)
            }
            "checkConnected" -> {
                checkConnected(result)
            }
            "checkInitialized" -> {
                checkConnected(result)
            }
            "disConnect" -> {
                disConnect(result)
            }
            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    //region RFID Functions
    private fun initReader(result: Result) {
        try {
            reader = RFIDFunctions(context, PortTypeEnum.BluetoothLE)
            reader!!.protocolType = ProtocolTypeEnum.Protocol_v4
            reader!!.interfaceType = InterfaceTypeEnum.UHF
            reader!!.initialize()
            result.success(true)
        } catch (e: MssException) {
            result.error("1", e.toString(), e.toString())
            e.printStackTrace()
        }catch (e : Exception){
            result.error("1", e.toString(), e.toString())
            e.printStackTrace()
        }finally {

        }
    }

    // endregion RFID Functions

    // region identifyReader
    private fun identifyTag(result: Result) {
        if(reader!=null && reader?.isConnected == true){
            try {
                val readerInfo = reader!!.identify()
                val UID: ByteArray?
                UID = reader!!.identify()
                result.success(HelperFunctions().bytesToHexStr(UID!!))
            } catch (e: MssException) {
                e.printStackTrace()
                result.error("2", "identify", e.localizedMessage)
            } catch (e: Exception) {
                e.printStackTrace()
                result.error("2", "identify", e.localizedMessage)
            }
        }

    }
    // endregion identifyReader

    // region checkConnected
    private fun checkConnected(result: Result) {
        if (reader?.isConnected == true) {
            result.success(true)
        } else {
            result.success(false)
        }
    }
    // endregion checkConnected

    // region checkInitialized
    private fun checkInitialized(result: Result) {
        if (reader != null) {
            result.success(true)
        } else {
            result.success(false)
        }
    }
    // endregion checkInitialized

    // region checkConnected
    private fun disConnect(result: Result) {
        if (reader != null && reader?.isConnected == true) {
            reader?.terminate();
        } else {
            result.error("3", "Reader is not connected", "Reader is not connected")
        }
    }
    // endregion checkConnected
}
