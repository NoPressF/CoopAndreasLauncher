import 'package:pub_semver/pub_semver.dart';

class VersionController {
  static final Version latestModVersion = Version.parse('0.1.0');
  static final Version latestLauncherVersion = Version.parse('0.1.0');

  static final Version currentModVersion = Version.parse('0.1.0');
  static final Version currentLauncherVersion = Version.parse('0.1.0');

  static bool isModUpdateRequired() {
    var constraint = VersionConstraint.parse(">=$latestModVersion");
    return !constraint.allows(currentModVersion);
  }

  static bool isLauncherUpdateRequired() {
    var constraint = VersionConstraint.parse(">=$latestLauncherVersion");
    return !constraint.allows(currentLauncherVersion);
  }
}