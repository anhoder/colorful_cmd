part of lang;

List<String> toLocal(List<String> list, Map<String, String> lang) {
  if (lang == null) return list;
  var res = list.map((item) {
    if (lang.containsKey(item)) {
      return lang[item];
    } else {
      return item;
    }
  });

  return res.toList();
}