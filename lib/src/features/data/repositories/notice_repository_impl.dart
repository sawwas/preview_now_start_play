import 'package:preview_play/src/features/data/api/notice_api.dart';
import 'package:preview_play/src/features/domain/repositories/notice_repository.dart';

class NoticeRepositoryImpl implements NoticeRepository {
  final NoticeApi noticeApi;

  const NoticeRepositoryImpl({required this.noticeApi});

  @override
  Future<String?> fetchBase64() {
    return noticeApi.fetchNoticeBase64();
  }
}
