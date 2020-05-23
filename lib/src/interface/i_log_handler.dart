part of logger;

abstract class ILogHandler {
  /// log is colorful?
  bool get colorful;

  void handle(String log);

  void handleInfo(String log) => handle(log);

  void handleDebug(String log) => handle(log);

  void handleWarning(String log) => handle(log);

  void handleTrace(String log) => handle(log);

  void handleError(String log) => handle(log);
}
