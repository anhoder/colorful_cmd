part of component;

class NotifierProxy {
  INotifier _notifier;

  NotifierProxy({List<INotifier> linux, List<INotifier> mac, List<INotifier> win}) {
    if (Platform.isLinux && linux != null) {
      for (var i = 0; i < linux.length; i++) {
        if (linux[i].isAvailable()) {
          _notifier = linux[i];
          break;
        }
      }
    } else if (Platform.isMacOS && mac != null) {
      for (var i = 0; i < mac.length; i++) {
        if (mac[i].isAvailable()) {
          _notifier = mac[i];
          break;
        }
      }
    } else if (Platform.isWindows && win != null) {
      for (var i = 0; i < win.length; i++) {
        if (win[i].isAvailable()) {
          _notifier = win[i];
          break;
        }
      }
    }
  }

  void send(String message, {String title, String subtitle, String soundName, String groupID, String activateID, String appIcon, String contentImage, String openURL, String executeCmd}) {

    if (_notifier == null) return;

    _notifier.send(message, title: title, subtitle: subtitle, soundName: soundName, groupID: groupID, activateID: activateID, appIcon: appIcon, contentImage: contentImage, openURL: openURL, executeCmd: executeCmd);
  }
}