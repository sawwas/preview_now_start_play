import 'package:dio/dio.dart';

import '../const.dart';
import '../sentryCaptureException.dart';

class CaptureContext {
  final Map<String, dynamic>? extra;
  final Map<String, dynamic>? tags;

  CaptureContext({this.extra, this.tags});
}

class ErrorHandlerParams {
  final ErrorLevel level;
  final String? reason;
  final dynamic error;
  final CaptureContext context;

  ErrorHandlerParams({
    required this.level,
    this.reason,
    required this.error,
    required this.context,
  });
}

Map<String, dynamic>? getRequestErrorInfo(dynamic error) {
  try {
    final request = error.request;
    final config = error.config;
    final response = error.response ?? {};

    if (request == null && config == null) {
      return null;
    }

    final status = response['status'];
    final headers = response['headers'];

    return {'url': config.url, 'method': config.method, 'status': status};
  } catch (_) {
    return null;
  }
}

ErrorHandlerParams errorHandler(
  ErrorLevel defaultLevel,
  String label,
  String describe, {
  required Exception err,
  CaptureContext? context,
}) {
  var error = err;
  final messageFromError = error.toString();
  final defaultTags = context?.tags ?? {};
  final originExtra = context?.extra ?? {};

  var level = defaultLevel;
  var reason = messageFromError;
  final extra = {
    '_inner': {
      'level': level,
      'label': label,
      'describe': describe,
      'messageFromError': messageFromError,
      'stack': '',
    },
    ...format(originExtra),
  };

  // if (error is! Exception) {
  //   error = Error.safeToString(err) as Exception;
  // }

  if (error is DioException) {
    final requestErrorInfo = getRequestErrorInfo(err);
    if (CancelToken.isCancel(error)) {
      reason = 'Request Cancel';
      level = ErrorLevel.info;
    } else if (requestErrorInfo != null) {
      // (error as DioException).response = null;
      final status = requestErrorInfo['status'];
      final url = requestErrorInfo['url'];
      final method = requestErrorInfo['method'];
      reason = 'network err $method $status';
      extra['_inner']['url'] = url;
      final tempE = Error();
      extra['_inner']['stack'] = tempE.stackTrace.toString();
    }
  }

  final tags = {
    'business': 'Unknown',
    'isCustomReported': true,
    ...format(defaultTags),
  };

  return ErrorHandlerParams(
    level: level,
    reason: reason,
    error: error,
    context: CaptureContext(extra: extra, tags: tags),
  );
}
