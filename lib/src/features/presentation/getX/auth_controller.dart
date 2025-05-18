import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:preview_play/constants/common_libs.dart';
import 'package:preview_play/env/config.dart';
import 'package:preview_play/src/features/data/models/notice/notice_model.dart';
import 'package:preview_play/src/features/data/repositories/auth_repository_impl.dart';
import 'package:preview_play/src/features/data/repositories/notice_repository_impl.dart';
import 'package:preview_play/utils/logs.dart';
import 'package:preview_play/utils/network/http_util.dart';

class AuthController extends GetxController {
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  var isLoading = false.obs;
  var isAuthenticated = false.obs;
  var message = ''.obs;

  final AuthRepositoryImpl authRemoteDataAPI = sl();

  final NoticeRepositoryImpl noticeRepositoryImpl = sl();

  Future<void> register(String username, String email, String password) async {
    isLoading.value = true;
    try {
      final user = await authRemoteDataAPI.register(username, email, password);
      message.value = '注册成功';
      isAuthenticated.value = true;
      ToastV2.show(message.value);
    } catch (e) {
      message.value = '注册失败';
      isAuthenticated.value = false;
      ToastV2.show(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login(String email, String password) async {
    ///TODO：测试参考 - Start
    // 测试代码：
    final cryptString = await noticeRepositoryImpl.fetchBase64();
    // 解这段代码试试：
    // 4a7287cb5e427ded881de38e2b51c5c0983830e14fbbf583b7ff7247f245262a1d7d6dc902f6fc2297da8f527f3fc419ff05718cc0941ccecaae685cabe4e97ad8dc23311545dc2841227c692b81663a2f47c5b04458f4333a4d092218b4559b2c923e173d99115a28a37afd9bb87062ecd6e814ebdfcea0673b0f72414be669057de6857ed259fc75f865271ab85e7f02e2a296fdd0e48ad26a3557571bcf7f
    //
    // 解出来结果：
    // {"id":1922963710465282048,"username":"bad22bbdbb","token":"uuid|192.168.0.200|a77e1906890648cc30e563b46a63cf04b1edcd71c5026368b2ad082291bc9346"}

    if (cryptString != null && cryptString.isNotEmpty) {
      final result = EncryptUtil().decryptAesCbc(
        cryptString,
        // '737b25e6e534a7dc5e2ca9ed75298de44276fc3f54e14cd86562e1c379d2d01e6cccd67abaeeee5a1a7ba97ca4e98385b568b0312dfe79caacd952b61cbf24ce9f69fcd80898f28cd607533a767daa9aab325ac24e928321c97e31b6e4dc345dc73971471491a0d9c3ca37ab08fe2727fb55083a571de6290cd1a84439f8a411b98b58421ec3248fc640794213eb3f2c41cc1cf66ccb71f98e899ce499575a70045e1e2f8de26ac76080abc6fa7d7eae737c55d1e4b7530618704fc9a05bbefc473f67fa490b9560e9f5c0e193d1121b53842c9b46c882e843ded64916eb1058',
        config.keyBase64,
        config.ivBase64,
      );
      final noticeResult = NoticeResponse.fromJson(jsonDecode(result));
      logger.i('noticeResult: ${noticeResult.toJson()}');
    }

    ///TODO：测试参考 - End
    ///
    ///
    ///
    ///TODO：正常逻辑需放开
    /*isLoading.value = true;

    try {
      final user = await authRemoteDataAPI.login(email, password);
      await _storage.write(key: 'token', value: user?.token);
      await _storage.write(key: 'userId', value: user?.id);
      message.value = '登录成功';
      isAuthenticated.value = true;
      ToastV2.show(message.value);
      _socketService.reconnectManualSocket();
    } catch (e) {
      message.value = '登录失败';
      isAuthenticated.value = false;
      ToastV2.show(e.toString());
    } finally {
      isLoading.value = false;
      
    }*/
  }
}
