import 'package:freezed_annotation/freezed_annotation.dart';

part 'daily_question_model.freezed.dart';
part 'daily_question_model.g.dart';

@freezed
class DailyQuestionModel with _$DailyQuestionModel {
  const factory DailyQuestionModel({required String? content}) =
      _DailyQuestionModel;

  factory DailyQuestionModel.fromJson(Map<String, dynamic> json) =>
      _$DailyQuestionModelFromJson(json);
}
