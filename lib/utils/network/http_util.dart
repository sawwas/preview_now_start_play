import 'dart:io';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:get_it/get_it.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sentry_dio/sentry_dio.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../env/config.dart';
import '../../main.dart';
import '../exception/api_exceptions.dart';
import '../logs.dart';
import '../sentry/sentry_interceptor.dart';

const String urlScheme = r'http(s?)://';
final RegExp urlRegExp = RegExp(urlScheme);
final GetIt sl = GetIt.instance;

class HttpUtil {
  const HttpUtil._();

  static late final Dio dio;
  static late final PersistCookieJar cookieJar;
  static late final CookieManager cookieManager;
  static final BaseOptions baseOptions = BaseOptions(
    /// curl 'http://43.199.222.3:8000/api/v1/notice' \
    // -H 'user-agent: Dart/3.7 (dart:io)' \
    // -H 'wskio-id: 59dee50e-29ec-59b1-9d7b-36471c4bfc86' \
    // -H 'lang: en' \
    // -H 'version: 1.0.0' \
    // -H 'host: 43.199.222.3:8000' \
    // -H 'device-id: fe073cf5-70f7-5172-bd88-5eb178d0c6f8' \
    // -H 'content-type: text/plain' \
    // -H 'platform: android' \
    // -H 'refer: default' \
    // --proxy http://localhost:9090
    // 抓包：先重定向后返回完成
    followRedirects: true,
    maxRedirects: 1,
    baseUrl: config.appBackendAddress,
    connectTimeout: const Duration(seconds: 30),
    sendTimeout: const Duration(seconds: 30),
    receiveTimeout: const Duration(seconds: 60),
    receiveDataWhenStatusError: true,
  );

  static Future<void> init() async {
    initManager(await getTemporaryDirectory());
  }

  @visibleForTesting
  static void initManager(Directory temporaryDir) {
    final String cookiesPath = '${temporaryDir.path}/persist_cookies/';
    Directory(cookiesPath).createSync(recursive: true);
    cookieJar = PersistCookieJar(storage: FileStorage(cookiesPath));
    cookieManager = CookieManager(cookieJar);
    dio =
        Dio()
          ..options = baseOptions
          ..interceptors.addAll([cookieManager, SentryErrorInterceptor()])
          ..addSentry();
    dio.interceptors.add(
      RetryInterceptor(
        dio: dio,
        logPrint: print,
        retries: 3,
        retryDelays: const [
          Duration(seconds: 1),
          Duration(seconds: 2),
          Duration(seconds: 3),
        ],
        retryEvaluator: (error, i) {
          return error.error.toString().contains(
            'Connection closed before full header was received',
          );
          // return error.response?.statusCode == 999;
        }
      ),
    );
    // dio.interceptors.add(InterceptorsWrapper(
    //   onResponse: (response, handler) {
    //     /// 处理301重定向
    //     if (response.statusCode == 301) {
    //       // 获取重定向URL
    //       String redirectUrl = response.headers['location']?.first ?? '';
    //       if (redirectUrl.isNotEmpty) {
    //         // 发起新请求
    //         dio.get(redirectUrl).then((newResponse) {
    //           handler.next(newResponse);
    //         }).catchError((e) {
    //           handler.reject(e);
    //         });
    //         return;
    //       }
    //     }
    //     handler.next(response);
    //   },
    // ));
  }

  static debugSetClientAdater(HttpClientAdapter adapter) {
    dio.httpClientAdapter = adapter;
  }

  static Future<T> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic> params = const {},
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      // if (path == '/start') {
      //   dio.options.baseUrl = 'https://livedev.mobus.workers.dev/api';
      // } else {
      //   dio.options.baseUrl = Config.appServerAddress;
      // }
      final response = await dio.post<T>(
        path,
        data: data,
        onSendProgress: (int sent, int total) {
          logger.d('$sent $total');
        },
        queryParameters: params,
        cancelToken: cancelToken,
        options: options,
      );
      if (response.statusCode != HttpStatus.ok) {
        throw ApiExceptions(
          response.statusCode,
          'Request error: ${response.statusCode}',
        );
      }
      return response.data!;
    } on DioException catch (e) {
      Sentry.captureException(e);

      throw ApiExceptions(
        int.tryParse(e.response?.data?['code'].toString() ?? '-1'),
        e.response?.data?['message']?.toString() ?? 'Unknown error',
      );
    } catch (e) {
      Sentry.captureException(e);
      rethrow;
    }
  }

  ///feat: story edit put request
  static Future<T> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic> params = const {},
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      // if (path == '/start') {
      //   dio.options.baseUrl = 'https://livedev.mobus.workers.dev/api';
      // } else {
      //   dio.options.baseUrl = Config.appServerAddress;
      // }
      final response = await dio.put<T>(
        path,
        data: data,
        onSendProgress: (int sent, int total) {
          logger.d('$sent $total');
        },
        queryParameters: params,
        cancelToken: cancelToken,
        options: options,
      );
      if (response.statusCode != HttpStatus.ok) {
        throw ApiExceptions(
          response.statusCode,
          'Request error: ${response.statusCode}',
        );
      }
      return response.data!;
    } on DioException catch (e) {
      Sentry.captureException(e);
      throw ApiExceptions(
        e.response?.data?['code'] as int?,
        e.response?.data?['message']?.toString() ?? 'Unknown error',
      );
    } catch (e) {
      Sentry.captureException(e);
      rethrow;
    }
  }

  static Future<T> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic> params = const {},
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      final response = await dio.delete<T>(
        path,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken,
        options: options,
      );
      if (response.statusCode != HttpStatus.ok) {
        throw ApiExceptions(
          response.statusCode,
          'Request error: ${response.statusCode}',
        );
      }
      return response.data!;
    } on DioException catch (e) {
      Sentry.captureException(e);
      throw ApiExceptions(
        e.response?.data?['code'] as int,
        e.response?.data?['message']?.toString() ?? 'Unknown error',
      );
    } catch (e) {
      Sentry.captureException(e);
      rethrow;
    }
  }

  static Future<T> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic> params = const {},
    CancelToken? cancelToken,
    Options? options,
  }) async {
    try {
      final response = await dio.get<T>(
        path,
        data: data,
        queryParameters: params,
        cancelToken: cancelToken,
        options: options,
      );
      if (response.statusCode != HttpStatus.ok) {
        throw ApiExceptions(
          response.statusCode,
          'Request error: ${response.statusCode}',
        );
      }
      return response.data!;
    } on DioException catch (e) {
      final responseData = e.response?.data;
      if (responseData == null || e.response?.data?['code'] == null) {
        Sentry.captureException(e);
        throw ApiExceptions(-1, str.serviceError);
      }
      Sentry.captureException(e);
      throw ApiExceptions(
        e.response?.data?['code'] as int,
        e.response?.data?['message']?.toString() ?? 'Unknown error',
      );
    } catch (e) {
      Sentry.captureException(e);
      rethrow;
    }
  }
}
