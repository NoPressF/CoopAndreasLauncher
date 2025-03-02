import 'package:flutter/cupertino.dart';
import 'package:pub_semver/pub_semver.dart';
import '../../utils/extract_version.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class VersionController extends ChangeNotifier {
  static final VersionController _instance = VersionController._internal();

  factory VersionController() => _instance;

  VersionController._internal();

  Version currentModVersion = Version.none;
  final Version currentLauncherVersion = Version.parse('0.1.0');

  void update() {
    currentModVersion = ExtractVersion.getDllModVersion();
    notifyListeners();
  }

  String getCurrentModVersion(BuildContext context) {
    return currentModVersion == Version.none
        ? AppLocalizations.of(context)!.unknown
        : currentModVersion.toString();
  }

// static final Version latestModVersion = Version.parse('0.1.0');
// static final Version latestLauncherVersion = Version.parse('0.1.0');

// static bool isModUpdateRequired() {
//   var constraint = VersionConstraint.parse(">=$latestModVersion");
//   return !constraint.allows(currentModVersion);
// }
//
// static bool isLauncherUpdateRequired() {
//   var constraint = VersionConstraint.parse(">=$latestLauncherVersion");
//   return !constraint.allows(currentLauncherVersion);
// }
}
