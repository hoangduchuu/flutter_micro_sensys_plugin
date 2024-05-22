package com.developerfect.microsensys.micro_sensys


import de.microsensys.utils.InterfaceTypeEnum
import de.microsensys.utils.PortTypeEnum
import java.util.Locale

class HelperFunctions {
    fun bytesToHexStr(`var`: ByteArray): String? {
        val var1 = StringBuilder(
            Integer.toString((`var`[0].toInt() and 255) + 256, 16).substring(1).uppercase(
                Locale.getDefault()
            )
        )
        for (var2 in 1 until `var`.size) {
            var1.append(' ').append(
                Integer.toString((`var`[var2].toInt() and 255) + 256, 16).substring(1).uppercase(
                    Locale.getDefault()
                )
            )
        }
        return var1.toString()
    }

    fun getInterfaceTypeFromString(interfaceTypeString: String): Int {
        return when (interfaceTypeString) {
            "LF" -> InterfaceTypeEnum.LF
            "HF" -> InterfaceTypeEnum.HF
            "UHF" -> InterfaceTypeEnum.UHF
            else -> InterfaceTypeEnum.UHF
        }
    }

    fun getPortTypeFromString(portTypeString: String): Int {
        return when (portTypeString) {
            "USB" -> PortTypeEnum.USB
            "Bluetooth" -> PortTypeEnum.Bluetooth
            "BluetoothLE" -> PortTypeEnum.BluetoothLE
            "BLE" -> PortTypeEnum.BluetoothLE
            else -> PortTypeEnum.BluetoothLE
        }
    }
}