part of logger;

class FileLogHandler extends ILogHandler {

  @override
  bool get colorful => false;

  File file;

  /// options: 
  /// %Y: year
  /// %m: month
  /// %d: day
  /// %H: hour
  /// %i: minutes
  /// %s: seconds
  String dirPath;
  String fileName;

  FileLogHandler({this.dirPath, this.fileName});

  @override
  void handle(String log) {
    setLogFile();
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    file.writeAsStringSync('$log\n', mode: FileMode.append, flush: true);
  }
  
  /// set log file by now datetime
  void setLogFile() {
    fileName ??= '%Y-%m-%d.log';
    fileName = format_by_now_time(fileName);
    var index = fileName.indexOf('/');
    if ( index == 0) {
      fileName = fileName.substring(1, fileName.length);
    }
    
    dirPath ??= './log/%Y-%m';
    dirPath = format_by_now_time(dirPath);
    index = dirPath.lastIndexOf('/');
    if (index >= 0 && index == dirPath.length - 1) {
      dirPath = dirPath.substring(0, index);
    }

    file = File('$dirPath/$fileName');
  }
}