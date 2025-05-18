bool isObjectLike(dynamic value) {
  return value != null && (value is Object || value is Function);
}

String baseGetTag(dynamic value) {
  return value.runtimeType.toString();
}

bool isPlainObject(dynamic value) {
  if (!isObjectLike(value) || baseGetTag(value) != 'Object') {
    return false;
  }
  var proto = value is Map ? null : value.runtimeType;
  return proto == null || proto == Object;
}

bool isError(dynamic value) {
  if (!isObjectLike(value)) {
    return false;
  }

  var tag = baseGetTag(value);

  return tag == 'Error' ||
      tag.contains('Exception') ||
      // tag == 'DOMException' ||
      (value is Error && !isPlainObject(value));
}
