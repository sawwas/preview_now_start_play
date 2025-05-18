String getUrlPath(String url) {
  return url.split('?').first ?? '';
}

Map<String, dynamic> genErrorExtra(Map<String, dynamic> error) {
  return {
    'config': genExtraConfig(error['config'] ?? {}),
    'error': pick(error, ['code', 'name', 'message', 'stack']),
  };
}

Map<String, dynamic> genExtraConfig(Map<String, dynamic> config) {
  return pick(config, [
    'baseURL',
    'data',
    'params',
    'headers',
    'method',
    'timeout',
    'url',
  ]);
}

Map<String, dynamic> pick(Map<String, dynamic> source, List<String> keys) {
  final Map<String, dynamic> result = {};
  for (final key in keys) {
    if (source.containsKey(key)) {
      result[key] = source[key];
    }
  }
  return result;
}
