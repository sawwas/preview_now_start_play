import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice_model.freezed.dart';
part 'notice_model.g.dart';

@freezed
class NoticeResponse with _$NoticeResponse {
  const factory NoticeResponse({
    required int code,
    required Pagination pagination,
    @JsonKey(name: 'notice_list') required List<NoticeModel> noticeList,
  }) = _NoticeResponse;

  factory NoticeResponse.fromJson(Map<String, dynamic> json) =>
      _$NoticeResponseFromJson(json);
}

@freezed
class Pagination with _$Pagination {
  const factory Pagination({
    required int index,
    required int limit,
    required int total,
  }) = _Pagination;

  factory Pagination.fromJson(Map<String, dynamic> json) =>
      _$PaginationFromJson(json);
}

@freezed
class NoticeModel with _$NoticeModel {
  const factory NoticeModel({
    required int id,
    int? to,
    @JsonKey(name: 'notice_at') required int noticeAt,
    required String title,
    required String brief,
  }) = _NoticeModel;

  factory NoticeModel.fromJson(Map<String, dynamic> json) =>
      _$NoticeModelFromJson(json);
}