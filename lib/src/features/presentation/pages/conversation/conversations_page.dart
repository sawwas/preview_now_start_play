import 'package:preview_play/src/features/presentation/getX/conversations_controller.dart';
import 'package:preview_play/utils/logs.dart';

import '../../../../../constants/common_libs.dart';
import '../../../data/models/conversation_model.dart';
import '../../getX/contacts_controller.dart';
import '../chat/chat_page.dart';

class ConversationsPage extends StatelessWidget {
  ConversationsPage({super.key});

  final ContactsController contactsController = Get.find<ContactsController>();
  final conversationsController = Get.find<ConversationsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          str.messages,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 70,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search, color: Colors.white),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Text(str.recentConversation, style: sty.text.t2Medium),
          ),
          SizedBox(height: 10),

          // Container(
          //   height: 100,
          //   padding: EdgeInsets.all(5),
          //   child: ListView.builder(
          //     shrinkWrap: true,
          //     // physics: NeverScrollableScrollPhysics(),
          //     scrollDirection: Axis.horizontal,
          //     itemCount: 5,
          //     // itemCount: state.recentContacts.length,
          //     itemBuilder: (context, index) {
          //       // final contact = state.recentContacts[index];
          //       return _buildRecentContact(
          //         // contact.username, contact.profileImage, context);
          //         "username$index",
          //         "https://robohash.org/flutterdev?set=set${index + 1}&size=200x200",
          //         context,
          //       );
          //     },
          //   ),
          // ),
          GetBuilder<ContactsController>(
            builder: (controller) {
              final recentContacts = controller.recentContacts.value;
              final isLoading = controller.isLoading.value;
              if (recentContacts.isNotEmpty) {
                return Container(
                  height: 100,
                  padding: EdgeInsets.all(5),
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: recentContacts.length,
                    itemBuilder: (context, index) {
                      final contact = recentContacts[index];
                      return _buildRecentContact(
                        contact.username,
                        contact.profileImage,
                        contact.conversationId ?? '',
                        context,
                      );
                    },
                  ),
                );
              } else if (isLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return Center(child: Text('No recent contacts found'));
            },
          ),

          SizedBox(height: 10),

          // Expanded(
          //   child: Container(
          //     decoration: BoxDecoration(
          //       color: sty.colors.chatSubTitleColor.withValues(alpha: 0.2),
          //       borderRadius: BorderRadius.only(
          //         topLeft: Radius.circular(16),
          //         topRight: Radius.circular(16),
          //       ),
          //     ),
          //     child: ListView.builder(
          //       itemCount: 10,
          //       // itemCount: state.conversations.length,
          //       itemBuilder: (context, index) {
          //         // final conversation = state.conversations[index];
          //         // print(
          //         //   'conversation.participantImage : ${conversation.participantImage}',
          //         // );
          //         return GestureDetector(
          //           onTap: () {
          //             goChatPage(
          //               conversationId: '$index',
          //               mate: 'name$index',
          //               profileImage:
          //                   "https://robohash.org/flutterdev?set=set${index + 1}&size=200x200",
          //             );
          //             // Navigator.push(context, MaterialPageRoute(builder: (context) =>
          //             //   ChatPage(
          //             //     conversationId: conversation.id,
          //             //     mate: conversation.participantName,
          //             //     profileImage: conversation.participantImage,
          //             //   )
          //             // ));
          //           },
          //           child: _buildMessageTile(
          //             'name$index',
          //             // conversation.participantName,
          //             "https://robohash.org/flutterdev?set=set${index + 1}&size=200x200",
          //             // conversation.participantImage,
          //             "今天有什么有意思的事～",
          //             // conversation.lastMessage,
          //             DateTime.now().timeZoneName,
          //             // conversation.lastMessageTime.toString(),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: sty.colors.chatSubTitleColor.withValues(alpha: 0.2),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),

              child: GetBuilder<ConversationsController>(
                initState: (state) {},
                builder: (controller) {
                  final isLoading = controller.isLoading.value;
                  final errorMessage = controller.errorMessage.value;
                  List<ConversationModel> conversations =
                      controller.conversations.value;
                  if (isLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (conversations.isNotEmpty && errorMessage.isEmpty) {
                    return ListView.builder(
                      itemCount: conversations.length,
                      itemBuilder: (context, index) {
                        var conversation = conversations[index];
                        var i = index;
                        logger.i(
                          'conversation.participantImage : ${conversation.participantImage}',
                        );
                        return GestureDetector(
                          onTap: () {
                            Get.toNamed(
                              ScreenPaths.chatPage,
                              arguments: ChatPageArgs(
                                conversationId: conversation.id,
                                mate: conversation.participantName,
                                profileImage: conversation.participantImage,
                              ),
                            );
                          },
                          child: GetBuilder<ConversationsController>(
                            id: conversation.id,
                            builder: (controller) {
                              conversations = controller.conversations.value;
                              conversation = conversations[i];
                              return _buildMessageTile(
                                conversation.participantName,
                                conversation.participantImage,
                                conversation.lastMessage,
                                conversation.lastMessageTime != null
                                    ? conversation.lastMessageTime.toString()
                                    : '',
                              );
                            },
                          ),
                        );
                      },
                    );
                  } else if (!isLoading && errorMessage.isNotEmpty) {
                    return Center(
                      child: Tapped(
                        onTap: () {
                          conversationsController.fetchConversations();
                        },
                        child: Text(errorMessage),
                      ),
                    );
                  }
                  return Center(
                    child: Tapped(
                      onTap: () {
                        conversationsController.fetchConversations();
                      },
                      child: Text('No conversations found'),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Get.toNamed(ScreenPaths.contactsPage)?.then((value) async {
            // if (value == null) {
            //   // 重新加载最近联系人列表
            //    contactsController.loadRecentContacts();
            //   // 重新加载对话列表
            //    conversationsController.fetchConversations();
            // }
          });
        },
        backgroundColor: sty.colors.cardButton,
        child: Icon(Icons.contacts),
      ),
    );
  }

  goChatPage({
    required String conversationId,
    required String mate,
    required String profileImage,
  }) {
    Get.toNamed(
      ScreenPaths.chatPage,
      arguments: ChatPageArgs(
        conversationId: conversationId,
        mate: mate,
        profileImage: profileImage,
      ),
    );
  }

  Widget _buildMessageTile(
    String name,
    String image,
    String? message,
    String time,
  ) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: CircleAvatar(radius: 30, backgroundImage: NetworkImage(image)),
      title: Text(
        name,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      subtitle:
          message != null
              ? Text(
                message,
                style: TextStyle(color: Colors.grey),
                overflow: TextOverflow.ellipsis,
              )
              : null,
      trailing: Text(time, style: TextStyle(color: Colors.grey)),
    );
  }

  Widget _buildRecentContact(
    String name,
    String profileImage,
    String conversationId,
    BuildContext context,
  ) {
    return Tapped(
      onTap: () {
        goChatPage(
          conversationId: conversationId,
          mate: name,
          profileImage: profileImage,
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: NetworkImage(profileImage),
            ),
            SizedBox(height: 5),
            Text(name, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
      ),
    );
  }
}
