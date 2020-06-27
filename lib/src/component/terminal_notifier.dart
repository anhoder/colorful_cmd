part of component;

class TerminalNotifier implements INotifier {
  static const String _command = 'terminal-notifier';

  @override
  bool isAvailable() {
    var result = Process.runSync('which', [_command]);
    if (result.exitCode != 0) return false;
    return true;
  }

  @override
  void send(String message, {String title, String subtitle, String soundName, String groupID, String activateID, String appIcon, String contentImage, String openURL, String executeCmd}) {
    var args = <String>['-message', message];
    if (title != null) args.addAll(['-title', title]);
    if (subtitle != null) args.addAll(['-subtitle', subtitle]);
    if (soundName != null) args.addAll(['-sound', soundName]);
    if (groupID != null) args.addAll(['-group', groupID]);
    if (activateID != null) args.addAll(['-activate', activateID]);
    if (appIcon != null) args.addAll(['-appIcon', appIcon]);
    if (contentImage != null) args.addAll(['-contentImage', contentImage]);
    if (openURL != null) args.addAll(['-open', openURL]);
    if (executeCmd != null) args.addAll(['-execute', executeCmd]);

    Process.run(_command, args);
  }

}