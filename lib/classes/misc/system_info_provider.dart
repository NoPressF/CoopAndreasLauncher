import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

enum SystemClassInfoType { win32Processor, win32Diskdrive }

enum SystemPropertyInfoType { processorId, serialNumber }

class SystemInfoProvider {
  static String get(
      SystemClassInfoType classType, SystemPropertyInfoType propertyType) {
    try {
      if (classType == SystemClassInfoType.win32Processor &&
          propertyType == SystemPropertyInfoType.processorId) {
        return _executeCommand("wmic cpu get ProcessorId")
            .split('\n')[1]
            .trim();
      } else if (classType == SystemClassInfoType.win32Diskdrive &&
          propertyType == SystemPropertyInfoType.serialNumber) {
        return _executeCommand("wmic diskdrive get SerialNumber")
            .split('\n')[1]
            .trim();
      }
    } catch (e) {
      return "Unknown";
    }
    return "Unknown";
  }

  static String _executeCommand(String command) {
    ProcessResult result = Process.runSync("cmd", ["/C", command]);
    return result.stdout.toString();
  }

  static String getUniqueSystemId() {
    String cpuId = SystemInfoProvider.get(
        SystemClassInfoType.win32Processor, SystemPropertyInfoType.processorId);
    String diskSerial = SystemInfoProvider.get(
        SystemClassInfoType.win32Diskdrive,
        SystemPropertyInfoType.serialNumber);
    String combined =
        "$cpuId$diskSerial${Platform.environment['COMPUTERNAME']}${Platform.environment['USERNAME']}";

    var bytes = utf8.encode(combined);
    var hash = md5.convert(bytes);

    return hash.toString().substring(0, 8).toUpperCase();
  }
}
