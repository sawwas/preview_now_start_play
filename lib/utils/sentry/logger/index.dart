import 'package:dio/dio.dart';

import '../sentryCaptureException.dart';

enum ErrorLevel { info, warning, error, fatal }

class CaptureContext {
  final Map<String, dynamic>? extra;
  final Map<String, dynamic>? tags;

  CaptureContext({this.extra, this.tags});
}

typedef CaptureFunc =
    void Function(
      String label,
      String describe,
      Exception error, {
      CaptureContext? context,
    });

class ErrorHandlerParams {
  final ErrorLevel level;
  final String reason;
  final dynamic error;
  final CaptureContext context;

  ErrorHandlerParams({
    required this.level,
    required this.reason,
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
  // final messageFromError = error.message;
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
    ...originExtra,
  };

  // if (error is! Error) {
  //   error = Error.safeToString(err);
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
    ...defaultTags,
  };

  return ErrorHandlerParams(
    level: level,
    reason: reason,
    error: error,
    context: CaptureContext(extra: extra, tags: tags),
  );
}

class Sentry {
  final CaptureFunc fatal;
  final CaptureFunc error;
  final CaptureFunc warn;
  final CaptureFunc info;

  Sentry({
    required this.fatal,
    required this.error,
    required this.warn,
    required this.info,
  });
}

Sentry sentry = Sentry(
  fatal: (label, describe, error, {context}) {
    errorHandler(
      ErrorLevel.fatal,
      label,
      describe,
      err: error,
      context: context,
    );
  },
  error: (label, describe, error, {context}) {
    errorHandler(
      ErrorLevel.error,
      label,
      describe,
      err: error,
      context: context,
    );
  },
  warn: (label, describe, error, {context}) {
    errorHandler(
      ErrorLevel.warning,
      label,
      describe,
      err: error,
      context: context,
    );
  },
  info: (label, describe, error, {context}) {
    errorHandler(
      ErrorLevel.info,
      label,
      describe,
      err: error,
      context: context,
    );
  },
);

class Logger {
  final CaptureFunc fatal;
  final CaptureFunc error;
  final CaptureFunc warn;
  final CaptureFunc info;

  Logger({
    required this.fatal,
    required this.error,
    required this.warn,
    required this.info,
  });
}

Logger loggerST = Logger(
  fatal: sentry.fatal,
  error: sentry.error,
  warn: sentry.warn,
  info: sentry.info,
);

CaptureContext addBizTag(Business bizTag, {required CaptureContext context}) {
  final tags = context.tags ?? {};
  final bizTags = {...tags, 'business': bizTag};
  return CaptureContext(extra: context.extra, tags: bizTags);
}

typedef ContextHandler =
    CaptureContext Function(CaptureContext context, [String? bizTag]);

Logger getLogger(ContextHandler contextHandler) {
  return Logger(
    fatal: (label, describe, error, {context}) {
      sentry.fatal(
        label,
        describe,
        error,
        context: contextHandler(context ?? CaptureContext()),
      );
    },
    error: (label, describe, error, {context}) {
      sentry.error(
        label,
        describe,
        error,
        context: contextHandler(context ?? CaptureContext()),
      );
    },
    warn: (label, describe, error, {context}) {
      sentry.warn(
        label,
        describe,
        error,
        context: contextHandler(context ?? CaptureContext()),
      );
    },
    info: (label, describe, error, {context}) {
      sentry.info(
        label,
        describe,
        error,
        context: contextHandler(context ?? CaptureContext()),
      );
    },
  );
}

Logger loggerT = getLogger(
  (context, [bizTag]) => addBizTag(Business.Trade, context: context),
);
Logger loggerA = getLogger(
  (context, [bizTag]) => addBizTag(Business.OAUTH, context: context),
);
