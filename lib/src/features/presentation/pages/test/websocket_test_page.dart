import 'package:preview_play/app/hook_util.dart';
import 'package:preview_play/env/config.dart';
import 'package:preview_play/src/features/presentation/getX/websocket_controller.dart';
import 'package:preview_play/widgets/app_title.dart';

import '../../../../../constants/common_libs.dart';

class WebSocketTestPage extends StatelessWidget {
  WebSocketTestPage({super.key});

  WebSocketController webSocketController = Get.find<WebSocketController>();

  final TextEditingController _urlController = TextEditingController(
    text: config.appBackendSocket,
  );
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<WebSocketController>(
        dispose: (state) {
          _urlController.dispose();
          _messageController.dispose();
          _scrollController.dispose();
          webSocketController.disconnect();
        },
        builder: (controller) {
          final isConnected = webSocketController.isConnected.value;
          final statusMessage = webSocketController.statusMessage.value;
          final errors = webSocketController.errors.value;
          final messages = webSocketController.messages.value;

          // Scroll to bottom when messages change
          WidgetsBinding.instance.addPostFrameCallback(
            (_) => _scrollToBottom(),
          );

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppTitle(title: 'WebSocket Test Demo'),
                // Connection status
                const SizedBox(height: 16.0),

                // WebSocket URL input
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _urlController,
                        decoration: InputDecoration(
                          labelText: 'WebSocket URL',
                          border: OutlineInputBorder(),
                          hintText: config.appBackendSocket,
                        ),
                        enabled: !isConnected,
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed:
                          isConnected
                              ? () => webSocketController.disconnect()
                              : () => webSocketController.connect(
                                _urlController.text,
                                headers:
                                    buildOptions(
                                      app: app.controllerChange,
                                      isUseWsKio: true,
                                    ).headers,
                              ),
                      child: Text(isConnected ? 'Disconnect' : 'Connect'),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),

                if (errors.isNotEmpty)
                  Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.red.shade100,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      errors,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                if (errors.isNotEmpty) const SizedBox(height: 16.0),

                // Message history
                const Text(
                  'Messages:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child:
                        messages.isEmpty
                            ? const Center(child: Text('No messages yet'))
                            : ListView.builder(
                              controller: _scrollController,
                              itemCount: messages.length,
                              itemBuilder: (context, index) {
                                final message = messages[index];
                                final isSent = message.startsWith('Sent: ');

                                return Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 4.0,
                                  ),
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    decoration: BoxDecoration(
                                      color:
                                          isSent
                                              ? Colors.blue.shade50
                                              : Colors.grey.shade900,
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    child: Text(message),
                                  ),
                                );
                              },
                            ),
                  ),
                ),
                const SizedBox(height: 16.0),

                // Send message controls
                Row(
                  children: [
                    Expanded(
                      child: TextField(

                        controller: _messageController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          labelText: 'Message',
                          hintStyle: sty.text.t5Regular.copyWith(
                            color: Colors.white,
                          ),
                          labelStyle: sty.text.t5Regular.copyWith(
                            color: sty.colors.t4,
                          ),
                          border: OutlineInputBorder(),
                          hintText: 'Enter message to send',
                          prefixIconColor: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8.0),
                    ElevatedButton(
                      onPressed:
                          isConnected
                              ? () {
                                if (_messageController.text.isNotEmpty) {
                                  webSocketController.sendMessage(
                                    _messageController.text,
                                  );
                                  _messageController.clear();
                                }
                              }
                              : null,
                      child: const Text('Send'),
                    ),
                  ],
                ),
                const SizedBox(height: 8.0),
                // Clear messages button
                TextButton(
                  onPressed: () => webSocketController.clearHistoryMessages(),
                  child: const Text('Clear History Messages'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
