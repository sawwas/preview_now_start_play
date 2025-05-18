import 'package:dio/dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

const String spanKey = 'sentry_transaction';

createSentrySpan(RequestOptions options) {
  final method = options.method;
  final baseURL = options.baseUrl;
  final url = options.path;
  final span = Sentry.startTransaction(
    '【$method】$baseURL$url',
    'http.request',
    bindToScope: true,
  );
  options.extra[spanKey] = span;
}

endSentrySpan(Response response) {
  final span = response.requestOptions.extra[spanKey] as ISentrySpan?;
  if (span != null) {
    span.status = SpanStatus.fromHttpStatusCode(response.statusCode ?? -1);
    span.finish();
  }
}

handleSentrySpanError(DioException err) {
  final span = err.requestOptions.extra[spanKey] as ISentrySpan?;
  if (span != null) {
    span.throwable = err;
    span.status = const SpanStatus.internalError();
    span.setData('http.status_code', err.response?.statusCode ?? '');
    if (err.response?.data != null) {
      final data = err.response!.data;
      span.setData('http.res_code', data['code'] ?? 'unknown');
      span.setData('http.res_msg', data['message'] ?? data['msg'] ?? 'unknown');
    }
    span.finish();
  }
}
