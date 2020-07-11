part of component;

class AppleScriptNotifier implements INotifier {
  static const String _command = 'osascript';

  @override
  bool isAvailable() {
    try {
      var result = Process.runSync('which', [_command]);
      if (result.exitCode != 0) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void send(String message, {String title, String subtitle, String soundName, String groupID, String activateID, String appIcon, String contentImage, String openURL, String executeCmd}) {
    var args = 'display notification "${message}"';
    if (title != null) args += ' with title "${title}"';
    if (subtitle != null) args += ' subtitle "${subtitle}"';
    if (soundName != null) args += ' sound name "${soundName}"';
    
    Process.run(_command, ['-e', args]);
  }

}