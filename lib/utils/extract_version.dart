import 'dart:ffi';
import 'package:ffi/ffi.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:win32/win32.dart';
import '../classes/settings/game_path/game_path.dart';

class ExtractVersion {
  static Version getDllModVersion() {
    final dllPath = "${GamePath.getModPath}".toNativeUtf16();

    final versionInfoSize = GetFileVersionInfoSize(dllPath, nullptr);
    if (versionInfoSize == 0) {
      calloc.free(dllPath);
      return Version.none;
    }

    final versionInfo = calloc<Uint8>(versionInfoSize);
    if (GetFileVersionInfo(dllPath, 0, versionInfoSize, versionInfo) == 0) {
      calloc.free(versionInfo);
      calloc.free(dllPath);
      return Version.none;
    }

    final langCodePointer = calloc<Pointer<Uint16>>();
    final langCodeLength = calloc<Uint32>();

    if (VerQueryValue(versionInfo, "\\VarFileInfo\\Translation".toNativeUtf16(),
            langCodePointer.cast(), langCodeLength) ==
        0) {
      calloc.free(versionInfo);
      calloc.free(dllPath);
      calloc.free(langCodePointer);
      calloc.free(langCodeLength);
      return Version.none;
    }

    final langCode = langCodePointer.value.cast<Uint16>();
    final langId =
        (langCode[0] << 16 | langCode[1]).toRadixString(16).padLeft(8, '0');

    final queryPath =
        "\\StringFileInfo\\$langId\\ProductVersion".toNativeUtf16();
    final productVersionPointer = calloc<Pointer<Utf16>>();
    final productVersionLength = calloc<Uint32>();

    if (VerQueryValue(versionInfo, queryPath, productVersionPointer.cast(),
            productVersionLength) ==
        0) {
      calloc.free(versionInfo);
      calloc.free(dllPath);
      calloc.free(langCodePointer);
      calloc.free(langCodeLength);
      calloc.free(productVersionPointer);
      calloc.free(productVersionLength);
      return Version.none;
    }

    final productVersion = productVersionPointer.value.toDartString();

    calloc.free(versionInfo);
    calloc.free(dllPath);
    calloc.free(langCodePointer);
    calloc.free(langCodeLength);
    calloc.free(productVersionPointer);
    calloc.free(productVersionLength);

    return Version.parse(productVersion);
  }
}
