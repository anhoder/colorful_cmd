part of utils;

String format_by_now_time(String from) {
  var dateTime = DateTime.now();
  return from.replaceAll('%Y', dateTime.year.toString())
    .replaceAll('%m', dateTime.month.toString())
    .replaceAll('%d', dateTime.day.toString())
    .replaceAll('%H', dateTime.hour.toString())
    .replaceAll('%i', dateTime.minute.toString())
    .replaceAll('%s', dateTime.second.toString());
}