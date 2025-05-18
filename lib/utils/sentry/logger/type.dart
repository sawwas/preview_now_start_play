typedef SomeType = dynamic;

typedef StringTags = Map<String, String>;

class CaptureContext {
  final Map<String, dynamic>? extra;
  final Map<String, dynamic>? tags;

  CaptureContext({this.extra, this.tags});
}

typedef CaptureFunc =
    void Function(
      String label,
      String describe,
      Error error, [
      CaptureContext? context,
    ]);
