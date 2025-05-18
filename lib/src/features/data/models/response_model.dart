import 'package:freezed_annotation/freezed_annotation.dart';

part 'response_model.freezed.dart';

part 'response_model.g.dart';

@freezed
class ResponseModel<T> with _$ResponseModel<T> {
  const factory ResponseModel({
    required int code,
    required String message,
    required Object? result,
  }) = _ResponseModel<T>;

  factory ResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ResponseModelFromJson<T>(json);
}
