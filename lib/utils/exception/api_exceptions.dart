import 'package:preview_play/main.dart';

class ApiExceptions implements Exception {
  final int? code;
  final String message;

  ApiExceptions(this.code, this.message);

  @override
  String toString() {
    return message;
  }
}

errorVerificationCode(int errorCode) {
  String? errorMessage;

  ///400: 参数错误
  ///408: 请求超时
  ///429: 请求频繁
  ///500: 服务器内部错误
  switch (errorCode) {
    case 400:
      errorMessage = str.api_400;
      break;
    case 408:
      errorMessage = str.api_408;
      break;
    case 429:
      errorMessage = str.api_429;
      break;
    case 500:
      errorMessage = str.api_500;
      break;
    default:
      errorMessage = null;
      break;
  }
  return errorMessage;
}
