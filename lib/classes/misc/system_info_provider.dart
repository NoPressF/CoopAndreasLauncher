import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

enum SystemPropertyType { processorId, serialNumber }

class SystemInfoProvider {
  static String get(SystemPropertyType propertyType) {
    try {
      if (propertyType == SystemPropertyType.processorId) {
        return _executePowerShellCommand(
                "Get-WmiObject Win32_Processor | Select-Object -ExpandProperty ProcessorId")
            .trim();
      } else if (propertyType == SystemPropertyType.serialNumber) {
        return _executePowerShellCommand(
                "Get-WmiObject Win32_DiskDrive | Select-Object -ExpandProperty SerialNumber")
            .trim();
      }
    } catch (e) {
      return "Unknown";
    }
    return "Unknown";
  }

  static String _executePowerShellCommand(String command) {
    ProcessResult result = Process.runSync("powershell", ["-Command", command]);
    return result.stdout.toString();
  }

  static String getUniqueSystemId() {
    String processorId = SystemInfoProvider.get(SystemPropertyType.processorId);
    String serialNumber =
        SystemInfoProvider.get(SystemPropertyType.serialNumber);
    String combined =
        "$processorId$serialNumber${Platform.environment['COMPUTERNAME']}${Platform.environment['USERNAME']}";

    var bytes = utf8.encode(combined);
    var hash = md5.convert(bytes);

    return hash.toString().substring(0, 8).toUpperCase();
  }
}
