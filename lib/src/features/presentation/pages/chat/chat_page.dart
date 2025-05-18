import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:preview_play/constants/common_libs.dart';
import 'package:preview_play/src/features/presentation/getX/chat_controller.dart';

class ChatPageArgs {
  final String conversationId;
  final String mate;
  final String profileImage;

  ChatPageArgs({
    required this.conversationId,
    required this.mate,
    required this.profileImage,
  });
}

class ChatPage extends StatelessWidget {
  ChatPage({super.key});

  final ChatPageArgs args = Get.arguments;
  final TextEditingController _messageController = TextEditingController();

  final _storage = FlutterSecureStorage();
  String userId = '';
  String botId = '00000000-0000-0000-0000-000000000000';

  late String conversationId = args.conversationId;
  late String mate = args.mate;
  late String profileImage = args.profileImage;

  final ChatController chatController = Get.find<ChatController>();
  final ScrollController _scrollController = ScrollController();

  fetchUserId() async {
    userId = await _storage.read(key: 'userId') ?? '';
  }

  onceScrollPosition({bool isFirst = true}) {
    once(chatController.messages, (value) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        if (chatController.messages.value.isNotEmpty) {
          _scrollToBottom(isFirst: isFirst);
        }
      });
    });
  }

  void _sendMessage() {
    final content = _messageController.text.trim();
    if (content.isNotEmpty) {
      onceScrollPosition(isFirst: false);
      chatController.sendMessage(conversationId, content);

      _messageController.clear();
    }
  }

  void _scrollToBottom({bool isFirst = true}) {
    if (isFirst) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 10),
        curve: Curves.easeOut,
      );
    } else {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CircleAvatar(backgroundImage: NetworkImage(profileImage)),
            SizedBox(width: 10),
            Text(mate, style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        backgroundColor: sty.colors.tipNormalBgColor,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: GetBuilder<ChatController>(
        initState: (state) {
          chatController.loadMessages(conversationId);
          chatController.loadDailyQuestion(conversationId);
          fetchUserId();
          onceScrollPosition();
        },
        dispose: (state) {
          _messageController.dispose();
          _scrollController.dispose();
        },
        builder: (controller) {
          return Column(
            children: [
              Expanded(
                child:
                // ListView.builder(
                //   padding: EdgeInsets.all(20),
                //   itemCount: 10,
                //   // itemCount: state.messages.length,
                //   itemBuilder: (context, index) {
                //     // final message = state.messages[index];
                //     final isSentMessage = true;
                //     // final isSentMessage = message.senderId == userId;
                //     final isDailyQuestion = true;
                //     // final isDailyQuestion = message.senderId == botId;
                //
                //     if (isSentMessage) {
                //       return index % 3 == 0
                //           ? _buildSentMessage(context, "今天有什么有意思的事")
                //           : _buildReceivedMessage(context, "今天是个好事子，心想的事儿都能成");
                //       // return _buildSentMessage(context, message.content);
                //     }
                //     // else if(isDailyQuestion){
                //     //   return _buildDailyQuestionMessage(context, message.content);
                //     // }
                //     // else {
                //     //   return _buildReceivedMessage(context, message.content);
                //     // }
                //   },
                // ),
                Obx(() {
                  final isLoading = chatController.isLoading.value;
                  final messages = chatController.messages.value;

                  return Stack(
                    children: [
                      ListView.builder(
                        controller: _scrollController,
                        padding: EdgeInsets.all(20),
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final isSentMessage = message.senderId == userId;
                          final isDailyQuestion = message.senderId == botId;

                          if (isSentMessage) {
                            return _buildSentMessage(context, message.content);
                          } else if (isDailyQuestion) {
                            return _buildDailyQuestionMessage(
                              context,
                              message.content,
                            );
                          } else {
                            return _buildReceivedMessage(
                              context,
                              message.content,
                            );
                          }
                        },
                      ),
                      if (messages.isEmpty)
                        containerBg(
                          child: Center(child: Text('No messages found.')),
                        ),
                      if (chatController.error.value.isNotEmpty)
                        containerBg(
                          child: Center(
                            child: Text(chatController.error.value),
                          ),
                        ),
                      if (isLoading)
                        containerBg(
                          child: Center(child: CircularProgressIndicator()),
                        ),
                    ],
                  );
                }),
              ),
              _buildMessageInput(),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(right: 30, top: 5, bottom: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: sty.colors.chatSubTitleColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }

  Widget _buildSentMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: EdgeInsets.only(right: 30, top: 5, bottom: 5),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: sty.colors.chatSysTitleColor.withValues(
            alpha: 0.5,
            blue: 0.3,
            green: 0.7,
            red: 0.5,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(message, style: Theme.of(context).textTheme.bodyMedium),
      ),
    );
  }

  Widget _buildDailyQuestionMessage(BuildContext context, String message) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          // color: DefaultColors.dailyQuestionColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Text(
          "🧠 Daily Question : $message",
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
        ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
        color: sty.colors.tipNormalBgColor.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(25),
      ),
      margin: EdgeInsets.all(20),
      padding: EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        children: [
          GestureDetector(
            child: Icon(Icons.camera_alt, color: Colors.grey),
            onTap: () {},
          ),
          SizedBox(width: 10),
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: InputDecoration(
                hintText: "Message",
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(width: 10),
          GestureDetector(
            onTap: _sendMessage,
            child: Icon(Icons.send, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget containerBg({required Widget child}) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: sty.colors.bg1,
      child: child,
    );
  }
}
