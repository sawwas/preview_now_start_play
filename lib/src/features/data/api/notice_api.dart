import 'package:preview_play/src/features/data/api/app_api.dart';

class NoticeApi {
  NoticeApi();

  ///测试
  Future<String?> fetchNoticeBase64() async {
    final response = await AppApi().post(
      'v1/notice/',
      contentType: 'text/plain',
      data: {"index": 1, "limit": 20},
    );

    if (response != null) {
      return 'messages';
    } else {
      throw Exception('Failed to fetch Messages');
    }
  }
}
