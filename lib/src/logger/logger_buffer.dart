part of logger;

enum LogLevel {
  info,
  debug,
  warning,
  trance,
  error
}

class LoggerBuffer {
  ILogHandler logHandler;

  void info([Object content]) => log(LogLevel.info, content);

  void debug([Object content]) => log(LogLevel.debug, content);

  void warning([Object content]) => log(LogLevel.warning, content);

  void warn([Object content]) => warning(content);

  void error([Object content]) => log(LogLevel.error, content);

  void err([Object content]) => error(content);

  void log(LogLevel level, [Object content]) {

  }
}