import 'package:dio/dio.dart';
import 'package:preview_play/utils/sentry/utils.dart';

import '../../main.dart';
import 'const.dart';
import 'handleSentrySpan.dart';
import 'logger/index.dart';
import 'logger/isError.dart';

class SentryErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    try {
      final response = err.response;
      if (response?.data['code'].toString() == '20001') {
        app.logout();
        return;
      }

      handleSentrySpanError(err);
      final config = err.requestOptions;
      final url = getUrlPath(config.path ?? '');
      final status = response?.statusCode ?? err.response?.statusCode;
      final code = err.type.toString() ?? err.response?.statusCode?.toString();
      final msg = response?.data['message'] ?? err.message;
      final noErrorInfo = status == null && code == null && msg == null;
      final ignoreError =
      // isOauthPage() &&
      SENTRY_OAUTH_HTTP_IGNORE_ERROR_STATUS.contains(
        int.parse(status.toString()),
      );

      if (noErrorInfo || ignoreError) {
        return;
      }
      final errMsg = 'res err: $code;$url;($msg)';
      loggerST.error(
        'API',
        errMsg,
        Exception(msg),
        context: CaptureContext(
          extra:
              err is Map<String, dynamic>
                  ? genErrorExtra(err.response?.extra ?? {})
                  : {},
          // extra: err is Map<String, dynamic> ? genErrorExtra(err.requestOptions.extra) : {},
        ),
      );
    } catch (error) {
      if (isError(error) && error is Exception) {
        loggerST.error('Dio', 'interceptors reject err', error);
      }
    }
    handler.next(err);
  }
}
