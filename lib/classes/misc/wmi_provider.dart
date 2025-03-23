import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';

class WMIProvider {
  static String get(String component, String key) {
    try {
      ProcessResult result = Process.runSync(
          'powershell', ['-Command', '(Get-WmiObject -Class $component).$key'],
          runInShell: true);

      if (result.exitCode == 0) {
        return result.stdout.toString().trim();
      }
    } catch (e) {
      return "Unknown";
    }

    return "Unknown";
  }

  static Future<String> getUniqueSystemId() async {
    String processorId = WMIProvider.get('Win32_Processor', 'ProcessorId');
    String serialNumber = WMIProvider.get('Win32_DiskDrive', 'SerialNumber')
        .split('\n')[0]
        .trim();
    String combined =
        "$processorId$serialNumber${Platform.environment['COMPUTERNAME']}${Platform.environment['USERNAME']}";
    var bytes = utf8.encode(combined);
    var hash = md5.convert(bytes);

    return hash.toString().substring(0, 8).toUpperCase();
  }
}
