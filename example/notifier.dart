import 'package:colorful_cmd/component.dart';

void main(List<String> args) {
  var notifierProxy = NotifierProxy(mac: [TerminalNotifier(), AppleScriptNotifier()], linux: [NotifySendNotifier()]);
  notifierProxy.send('This is notify!', title: 'notify title', subtitle: 'notify subtitle', groupID: 'colorful_cmd', openURL: 'http://github.com/AlanAlbert');
}