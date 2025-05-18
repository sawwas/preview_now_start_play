import 'dart:async';

import 'package:intl/intl.dart';
import 'package:preview_play/constants/common_libs.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/status.dart' as status;

import '../../../../utils/logs.dart';
import '../../../generated/protos/ws.pb.dart';
import '../../../snappy_android.g.dart';

class WebSocketController extends GetxController {
  IOWebSocketChannel? _channel;
  StreamSubscription? _subscription;
  var isConnected = false.obs;
  var statusMessage = 'Disconnected'.obs;
  var messages = <String>[].obs;
  var errors = ''.obs;

  /// 自动重连
  Timer? _reconnectTimer;
  String? _lastConnectedUrl;
  Map<String, dynamic>? _lastHeaders;
  var autoReconnect = true.obs;
  var reconnectAttempts = 0.obs;
  final int _maxReconnectAttempts = 5;
  final Duration _reconnectInterval = const Duration(seconds: 3);

  final SnappyApi _snappyApi = SnappyApi();

  set setAutoReconnect(bool value) {
    autoReconnect.value = value;
    refresh();
  }

  @override
  void onInit() {
    super.onInit();
    SnappyNativeCallbackApi.setUp(
      SnappyNativeCallbackApiImplementation(
        unCompressedCallback: (data) {
          // logger.i('onUncompress: ${data.data}');
          final binaryData = data.data?.toList() ?? [];
          // 解析二进制数据为Package
          final package = Package.fromBuffer(binaryData);

          // 根据Package类型处理
          switch (package.kind) {
            case PackageKind.NONE:
              // 处理NONE类型
              break;

            case PackageKind.NEW_INSITE_NOTICE:
              // 解析data字段为PushNewInsiteNotice
              final notice = PushNewInsiteNotice.fromBuffer(package.data);
              try {
                final dateTimeUtc = DateTime.fromMillisecondsSinceEpoch(
                  notice.timestamp.toInt(),
                  isUtc: true,
                );
                String formattedDate = DateFormat(
                  'yyyy-MM-dd HH:mm:ss',
                ).format(dateTimeUtc);
                messages.value.add('Received: $formattedDate');
                logger.i('收到新的站内通知，时间: $formattedDate');
              } catch (_) {
                messages.value.add('Received: $Error');
                logger.i('收到新的站内通知，错误: $Error');
              }

              refresh();
              break;
          }
        },
      ),
    );
  }

  // Future<Package> parsePackage(Uint8List data) {
  //   try {
  //     // 方法1：使用fromBuffer静态方法（如果生成的类中有此方法）
  //     final package = Package.fromBuffer(data);
  //     return package;
  //
  //     // 或者方法2：创建实例并使用mergeFromBuffer
  //     // final package = Package();
  //     // package.mergeFromBuffer(data);
  //     // return package;
  //   } catch (e) {
  //     print('解析Protocol Buffer失败: $e');
  //     throw e;
  //   }
  // }

  void connect(String url, {Map<String, dynamic>? headers}) {
    try {
      _lastConnectedUrl = url;
      _lastHeaders = headers;

      reconnectAttempts.value = 0;

      /// 如果有 先关闭现有连接
      disconnect();

      statusMessage.value = 'Connecting...';
      refresh();
      _channel = IOWebSocketChannel.connect(Uri.parse(url), headers: headers);

      _subscription = _channel!.stream.listen(
        (message) {
          _handleMessage(message);
        },
        onDone: () {
          isConnected.value = false;
          statusMessage.value = 'Connection closed';
          refresh();
          ToastV2.showError(statusMessage.value);
          if (autoReconnect.value) {
            _scheduleReconnect();
          }
        },
        onError: (error) {
          isConnected.value = false;
          errors.value = 'Error: $error';
          statusMessage.value = 'Connection error';
          refresh();
          ToastV2.showError(statusMessage.value);

          if (autoReconnect.value) {
            _scheduleReconnect();
          }
        },
      );

      isConnected.value = true;
      statusMessage.value = 'Connected';
      errors.value = '';
      refresh();
      ToastV2.showSuccess(statusMessage.value);
    } catch (e) {
      isConnected.value = false;
      errors.value = 'Connection error: $e';
      statusMessage.value = 'Failed to connect';
      refresh();
      ToastV2.showError(statusMessage.value);

      if (autoReconnect.value) {
        _scheduleReconnect();
      }
    }
  }

  void _scheduleReconnect() {
    _reconnectTimer?.cancel();

    if (reconnectAttempts >= _maxReconnectAttempts) {
      statusMessage.value = 'Max reconnect attempts reached';
      errors.value =
          'Failed to reconnect after $_maxReconnectAttempts attempts';
      refresh();
      return;
    }

    reconnectAttempts.value++;

    statusMessage.value =
        'Reconnecting (attempt $reconnectAttempts of $_maxReconnectAttempts)...';
    refresh();
    _reconnectTimer = Timer(_reconnectInterval, () {
      if (_lastConnectedUrl != null && !isConnected.value) {
        connect(_lastConnectedUrl!, headers: _lastHeaders);
      }
    });
  }

  /// 手动重连
  void reconnect() {
    if (_lastConnectedUrl != null) {
      reconnectAttempts.value = 0;
      connect(_lastConnectedUrl!, headers: _lastHeaders);
    } else {
      errors.value = 'No previous connection to reconnect to';
      refresh();
    }
  }

  void disconnect() {
    _reconnectTimer?.cancel();
    _reconnectTimer = null;

    if (_channel != null) {
      _subscription?.cancel();
      _channel!.sink.close(status.normalClosure);
      _channel = null;
      isConnected.value = false;
      statusMessage.value = 'Disconnected';
      refresh();
      ToastV2.showWarn(statusMessage.value);
    }
  }

  void sendMessage(String message) {
    if (isConnected.value && _channel != null) {
      try {
        _channel!.sink.add(message);
        messages.value.add('Sent: $message');
      } catch (e) {
        errors.value = 'Failed to send message: $e';
      }
    } else {
      errors.value = 'Not connected to server';
    }
    refresh();
  }

  Future<void> transformCompress() async {
    // final user = SnappyData(Uint8List.fromList(elements)
    // );
    final snappyData = SnappyData(data: Uint8List.fromList([1, 2, 3, 4, 5]));

    try {
      final response = await _snappyApi.compress(snappyData);
      // setState(() {
      //   _message = response.message ?? 'User saved successfully';
      // });
    } catch (e) {
      // setState(() {
      //   _message = 'Error saving user: $e';
      // });
    }
  }

  Future<void> _handleMessage(dynamic message) async {
    try {
      if (message is Uint8List) {
        final snappyData = SnappyData(data: message);

        try {
          final response = _snappyApi.compress(snappyData);
          // setState(() {
          //   _message = response.message ?? 'User saved successfully';
          // });
        } catch (e) {
          // setState(() {
          //   _message = 'Error saving user: $e';
          // });
        }
        // try {
        //   final jsonData = jsonDecode(message);
        //   messages.value.add('Received: ${jsonEncode(jsonData)}');
        // } catch (_) {
        //   messages.value.add('Received: $message');
        // }
      } else {
        messages.value.add('Received: $message');
      }
    } catch (e) {
      errors.value = 'Error processing message: $e';
    }
    refresh();
  }

  void clearHistoryMessages() {
    messages.value.clear();
    errors.value = '';
    refresh();
  }

  @override
  void dispose() {
    _reconnectTimer?.cancel();
    disconnect();
    super.dispose();
  }
}

class SnappyNativeCallbackApiImplementation extends SnappyNativeCallbackApi {
  SnappyNativeCallbackApiImplementation({required this.unCompressedCallback});

  final void Function(SnappyData) unCompressedCallback;

  @override
  void onUncompress(SnappyData data) {
    unCompressedCallback(data);
  }
}
