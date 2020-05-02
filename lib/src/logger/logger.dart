part of logger;

enum LogLevel {
  info,
  debug,
  warning,
  trace,
  error
}

const Map<LogLevel,String> LOG_LEVEL_STRING = {
  LogLevel.info: 'INFO',
  LogLevel.debug: 'DEBUG',
  LogLevel.warning: 'WARNING',
  LogLevel.trace: 'TRACE',
  LogLevel.error: 'ERROR',
};

class Logger {
  List<ILogHandler> logHandlers;
  String format;

  Logger({this.logHandlers, this.format}) {
    logHandlers ??= [StdLogHandler()];
    format ??= '[DATE] [LEVEL] LOG';
  }

  Logger addLogHandler(ILogHandler logHandler) {
    logHandlers.add(logHandler);
    return this;
  }

  Logger setFormat(String format) {
    this.format = format;
    return this;
  }

  Logger info(Object content) => log(LogLevel.info, content);

  Logger debug(Object content) => log(LogLevel.debug, content);

  Logger warning(Object content) => log(LogLevel.warning, content);

  Logger warn(Object content) => warning(content);

  Logger trace(Object content) => log(LogLevel.trace, content);

  Logger error(Object content) => log(LogLevel.error, content);

  Logger err(Object content) => error(content);

  Logger log(LogLevel level, Object content) {
    if (!LOG_LEVEL_STRING.containsKey(level)) {
      throw LogLevelNotFoundException(level.toString());
    }
    var log = format.replaceAll('DATE', DateTime.now().toString())
      .replaceAll('LEVEL', LOG_LEVEL_STRING[level])
      .replaceAll('LOG', content.toString());
    handle(level, log);
    return this;
  }

  /// make log colorful
  void handle(LogLevel level, String log) {
    switch (level) {
      case LogLevel.info:
        logHandlers.forEach((logHandler) {
          var colorful = logHandler.colorful ?? false;
          var logContent = colorful ? ColorText().green(log).toString() : log;
          logHandler.handleInfo(logContent);
        });
        return ;
      case LogLevel.debug:
        logHandlers.forEach((logHandler) {
          var colorful = logHandler.colorful ?? false;
          var logContent = colorful ? ColorText().cyan(log).toString() : log;
          logHandler.handleDebug(logContent);
        });
        return ;
      case LogLevel.warning:
        logHandlers.forEach((logHandler) {
          var colorful = logHandler.colorful ?? false;
          var logContent = colorful ? ColorText().yellow(log).toString() : log;
          logHandler.handleWarning(logContent);
        });
        return ;
      case LogLevel.trace:
        logHandlers.forEach((logHandler) {
          var colorful = logHandler.colorful ?? false;
          var logContent = colorful ? ColorText().magenta(log).toString() : log;
          logHandler.handleTrace(logContent);
        });
        return ;
      case LogLevel.error:
        logHandlers.forEach((logHandler) {
          var colorful = logHandler.colorful ?? false;
          var logContent = colorful ? ColorText().red(log).toString() : log;
          logHandler.handleError(logContent);
        });
        return ;
      default:
        logHandlers.forEach((logHandler) => logHandler.handle(log));
        return;
    }
  }
}