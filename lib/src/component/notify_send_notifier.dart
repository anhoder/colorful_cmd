part of component;

class NotifySendNotifier implements INotifier {
  static const String _command = 'notify-send';

  @override
  bool isAvailable() {
    var result = Process.runSync('which', [_command]);
    if (result.exitCode != 0) return false;
    return true;
  }

  @override
  void send(String message, {String title, String subtitle, String soundName, String groupID, String activateID, String appIcon, String contentImage, String openURL, String executeCmd}) {
    var args = <String>[];
    if (groupID != null) args.addAll(['-a', groupID]);
    if (appIcon != null) args.addAll(['-i', appIcon]);
    if (title != null) args.add(title);
    
    args.add(message);

    Process.run(_command, args);
  }
}