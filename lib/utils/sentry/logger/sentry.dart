import 'package:sentry_flutter/sentry_flutter.dart';

import '../../logs.dart';
import '../const.dart';
import 'errorHandler.dart';

typedef CaptureFunc =
    void Function(
      String label,
      String describe,
      Exception error, {
      CaptureContext? context,
    });

void capture(
  ErrorLevel level,
  String label,
  String describe, {
  required Exception error,
  required CaptureContext context,
}) async {
  try {
    final detail = errorHandler(
      level,
      label,
      describe,
      err: error,
      context: context,
    );
    final reason = detail.reason;
    final level0 = detail.level;
    final context0 = detail.context;

    if (level0 == ErrorLevel.info) {
      await info(reason, context0);
    } else {
      final err = detail.error;
      final reasonStr = reason != null ? ' ($reason)' : '';
      err.message = '[$label] - $describe$reasonStr';

      await Sentry.captureException(
        err,
        stackTrace: err.stackTrace,
        withScope: (scope) {
          switch (level0) {
            case ErrorLevel.warning:
              scope.level = SentryLevel.warning;
              break;
            case ErrorLevel.error:
              scope.level = SentryLevel.error;
              break;
            case ErrorLevel.fatal:
              scope.level = SentryLevel.fatal;
              break;
            default:
              scope.level = SentryLevel.info;
              break;
          }
          scope.setContexts('context', context0);
        },
      );
    }
  } catch (e) {
    logger.i('sentry capture inner error: $e');
  }
}

Future<void> info(String? name, CaptureContext context) async {
  try {
    await Sentry.captureMessage(
      name ?? 'Something went wrong',
      withScope: (scope) {
        scope.setContexts('context', context);
      },
    );
  } catch (e) {
    logger.i('Sentry captureMessage: $e');
  }
}

void fatal(
  String label,
  String describe,
  Exception err, {
  CaptureContext? context,
}) {
  capture(ErrorLevel.fatal, label, describe, error: err, context: context!);
}

void error(
  String label,
  String describe,
  Exception err, {
  CaptureContext? context,
}) {
  capture(ErrorLevel.error, label, describe, error: err, context: context!);
}

void warn(
  String label,
  String describe,
  Exception err, {
  CaptureContext? context,
}) {
  capture(ErrorLevel.warning, label, describe, error: err, context: context!);
}

class SentryLogger {
  final CaptureFunc fatal;
  final CaptureFunc error;
  final CaptureFunc warn;
  final Function info;

  SentryLogger({
    required this.fatal,
    required this.error,
    required this.warn,
    required this.info,
  });
}

final sentry = SentryLogger(fatal: fatal, error: error, warn: warn, info: info);
