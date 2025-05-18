import 'const.dart';

enum Business {
  Trade,
  OAUTH, // auth-bot
}

typedef Extra = Map<String, dynamic>;

class Context {
  ErrorLevel? level;
  Extra? extra;
  Map<String, dynamic>? tags;

  Context({this.level, this.extra, this.tags});
}

/// Format the `extra` object by excluding any keys with values of `null`,
/// `undefined`, or an empty string.
/// @param extra The object to format.
/// @returns The formatted object.
Extra format(Extra extra) {
  final newExtra = <String, dynamic>{};
  extra.forEach((key, value) {
    if (value != null && value != '') {
      if (value is Error) {
        newExtra[key] = value.toString();
      } else if (value is Map) {
        newExtra[key] = value.toString();
      } else {
        newExtra[key] = value;
      }
    }
  });
  return newExtra;
}
