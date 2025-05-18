import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as secure;
import 'package:preview_play/app/hook_util.dart';
import 'package:preview_play/src/features/data/models/response_model.dart';
import 'package:preview_play/src/features/data/models/response_model_extension.dart';
import 'package:preview_play/src/features/data/models/user_model.dart';

import '../../../../constants/common_libs.dart';
import '../../../../utils/exception/api_exceptions.dart';
import '../../../../utils/network/http_util.dart';

class AppApi {
  static final AppApi _instance = AppApi._internal();

  var _storage;

  factory AppApi() {
    return _instance;
  }

  AppApi._internal() {
    _storage = secure.FlutterSecureStorage();
    verifyToken();
  }

  String? _tempToken;

  String? get tempToken_ => _tempToken;

  set setTempToken(String value) {
    _tempToken = value;
  }

  clearTempToken() {
    _tempToken = null;
  }

  verifyToken() async {
    if (app.controllerChange.currentUser.value == null ||
        (app.controllerChange.currentUser.value != null &&
            app.controllerChange.currentUser.value!.token == null)) {
      String token = await _storage.read(key: 'token') ?? '';
      String userId =
          await _storage.read(key: 'userId') ??
          app.controllerChange.currentUser.value?.id ??
          '';
      app.controllerChange.currentUser.value = UserModel(
        id: userId,
        username: app.controllerChange.currentUser.value?.username ?? '',
        email: app.controllerChange.currentUser.value?.email ?? '',
        token: token,
      );
    }
  }

  Future<T> get<T>(
    String path, {
    Object? data,
    Map<String, dynamic> params = const {},
    CancelToken? cancelToken,
    String? tokenStr,
    bool? notThrow,
    String contentType = 'application/json',
  }) async {
    await verifyToken();
    final token =
        tokenStr ?? app.controllerChange.currentUser.value?.token ?? _tempToken;
    // logger.d('sean============token: $token');
    final responseJson = await HttpUtil.get<Map<String, dynamic>>(
      path,
      data: data,
      params: params,
      cancelToken: cancelToken,
      options: buildOptions(
        app: app.controllerChange,
        contentType: contentType,
        token: token,
      ),
    );
    // logger.d('sean============token: ${responseJson}');
    // jsonEncode(responseJson);
    final response = ResponseModel.fromJson(responseJson);
    if (response.success) {
      return response.result as T;
    } else {
      if (notThrow == true) {
        return response as T;
      } else {
        ///400: 参数错误
        ///408: 请求超时
        ///429: 请求频繁
        ///500: 服务器内部错误
        final errorCode = response.code;
        throw ApiExceptions(
          response.code,
          errorVerificationCode(errorCode) ?? response.message,
        );
      }
    }
  }

  Future<T> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic> params = const {},
    CancelToken? cancelToken,
    String? tokenStr,
    String? mfa,
    bool? notThrow,
    String contentType = 'application/json',
  }) async {
    await verifyToken();

    final token =
        tokenStr ?? app.controllerChange.currentUser.value?.token ?? _tempToken;
    final responseJson = await HttpUtil.post<Map<String, dynamic>>(
      path,
      data: data,
      params: params,
      cancelToken: cancelToken,
      options: buildOptions(
        app: app.controllerChange,
        contentType: contentType,
        token: token,
      ),
    );
    final response = ResponseModel.fromJson(responseJson);
    if (response.success) {
      return response.result as T;
    } else {
      if (notThrow == true) {
        return response as T;
      } else {
        final errorCode = response.code;
        throw ApiExceptions(
          response.code,
          errorVerificationCode(errorCode) ?? response.message,
        );
      }
    }
  }

  Future<T> put<T>(
    String path, {
    Object? data,
    Map<String, dynamic> params = const {},
    CancelToken? cancelToken,
    String? tokenStr,
    String contentType = 'application/json',
  }) async {
    await verifyToken();

    final token =
        tokenStr ?? app.controllerChange.currentUser.value?.token ?? _tempToken;
    final responseJson = await HttpUtil.put<Map<String, dynamic>>(
      path,
      data: data,
      params: params,
      cancelToken: cancelToken,
      options: buildOptions(
        app: app.controllerChange,
        contentType: contentType,
        token: token,
      ),
    );
    final response = ResponseModel.fromJson(responseJson);
    if (response.success) {
      return response.result as T;
    } else {
      throw ApiExceptions(response.code, response.message);
    }
  }

  Future<T> delete<T>(
    String path, {
    Object? data,
    Map<String, dynamic> params = const {},
    CancelToken? cancelToken,
  }) async {
    await verifyToken();

    final token = app.controllerChange.currentUser.value?.token ?? _tempToken;
    final responseJson = await HttpUtil.delete<Map<String, dynamic>>(
      path,
      data: data,
      params: params,
      cancelToken: cancelToken,
      options:
          token == null
              ? null
              : Options(headers: {'Authorization': 'Bearer $token'}),
    );
    final response = ResponseModel.fromJson(responseJson);
    if (response.success) {
      return response.result as T;
    } else {
      throw ApiExceptions(response.code, response.message);
    }
  }
}
