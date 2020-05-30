part of lang;

String toLocal(ILang lang, String englishWord) {
  if (lang == null) return englishWord;
  var wordsMap = lang.wordsMap;
  return wordsMap.containsKey(englishWord) && wordsMap[englishWord] != null
      ? wordsMap[englishWord]
      : englishWord;
}

List<String> localHelpInfo(ILang lang) {
  var helpInfo =
      lang == null || lang.helpInfo == null ? HELP_INFO : lang.helpInfo;
  return helpInfo == null ? [] : helpInfo.split('\n');
}
