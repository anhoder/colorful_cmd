part of logger;

class StdLogHandler extends ILogHandler {
  
  @override
  bool get colorful => true;

  @override
  void handle(String log) {
    stdout.writeln(log);
  }

  @override
  void handleError(String log) {
    stderr.writeln(log);
  }
}