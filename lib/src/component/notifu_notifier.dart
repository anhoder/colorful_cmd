part of component;

class NotifuNotifier implements INotifier {
  static const String _command = 'notifu';

  @override
  bool isAvailable() {
    try {
      var result = Process.runSync('where', [_command]);
      if (result.exitCode != 0) return false;
      return true;
    } catch (e) {
      return false;
    }
  }

  @override
  void send(String message, {String title, String subtitle, String soundName, String groupID, String activateID, String appIcon, String contentImage, String openURL, String executeCmd}) {
    var args = <String>['/d', '2000'];
    if (title != null) {
      args.addAll(['/p', title]);
    }
    args.addAll(['/m', message]);

    Process.run(_command, args);
  }
  
}