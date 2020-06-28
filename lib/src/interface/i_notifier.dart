part of component;

abstract class INotifier {
  bool isAvailable();

  void send(String message, {String title, String subtitle, String soundName, String groupID, String activateID, String appIcon, String contentImage, String openURL, String executeCmd});
}