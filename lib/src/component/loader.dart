part of component;

/// code from console/TImerDisplay, optimize ui in windows
class Loader {
  Stopwatch _watch;
  bool _isStart = true;
  String _lastMsg;
  Timer _updateTimer;

  Loader();

  /// Starts the Timer
  void start([int place = 1]) {
    Console.adapter.echoMode = false;
    Console.adapter.lineMode = false;
    _watch = Stopwatch();
    _updateTimer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      update(place);
    });
    _watch.start();
  }

  /// Stops the Timer
  void stop() {
    Console.adapter.lineMode = true;
    Console.adapter.echoMode = true;
    _watch.stop();
    _updateTimer.cancel();
  }

  /// Updates the Timer
  void update([int place = 1]) {
    if (_isStart) {
      var msg = '(${_watch.elapsed.inSeconds}s)';
      _lastMsg = msg;
      // Console.write(msg);
      _isStart = false;
    } else {
      Console.moveCursorBack(_lastMsg.length);
      var msg =
          '(${(_watch.elapsed.inMilliseconds / 1000).toStringAsFixed(place)}s)';
      _lastMsg = msg;
      Console.setBold(true);
      Console.write(ColorText().gray(msg).toString());
      Console.setBold(false);
    }
  }
}