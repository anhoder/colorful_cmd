part of component;

class NotifierProxy {
  INotifier _linuxNotifier;
  INotifier _macNotifier;
  INotifier _winNotifier;

  NotifierProxy({List<INotifier> linux, List<INotifier> mac, List<INotifier> win}) {
    if (linux != null) {
      for (var i = 0; i < linux.length; i++) {
        if (linux[i].isAvailable()) {
          _linuxNotifier = linux[i];
          break;
        }
      }
    }
    if (mac != null) {
      for (var i = 0; i < mac.length; i++) {
        if (mac[i].isAvailable()) {
          _macNotifier = mac[i];
          break;
        }
      }
    }
    if (win != null) {
      for (var i = 0; i < win.length; i++) {
        if (win[i].isAvailable()) {
          _winNotifier = win[i];
          break;
        }
      }
    }
  }

  void send(String message, {String title, String subtitle, String soundName, String groupID, String activateID, String appIcon, String contentImage, String openURL, String executeCmd}) {
    INotifier notifier;
    if (Platform.isLinux) {
      notifier = _linuxNotifier;
    } else if (Platform.isMacOS) {
      notifier = _macNotifier;
    } else if (Platform.isWindows) {
      notifier = _winNotifier;
    }

    if (notifier == null) return;

    notifier.send(message, title: title, subtitle: subtitle, soundName: soundName, groupID: groupID, activateID: activateID, appIcon: appIcon, contentImage: contentImage, openURL: openURL, executeCmd: executeCmd);
  }
}