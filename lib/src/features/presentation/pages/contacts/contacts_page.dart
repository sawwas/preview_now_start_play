import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:preview_play/src/features/presentation/getX/contacts_controller.dart';
import 'package:preview_play/src/features/presentation/pages/chat/chat_page.dart';
import 'package:preview_play/router.dart';

import '../../../../../main.dart';

class ContactsPage extends StatelessWidget {
  ContactsPage({super.key});

  final contactsController = Get.find<ContactsController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          str.contacts,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: GetBuilder<ContactsController>(
        initState: (state) {},
        builder: (controller) {
          final isLoading = controller.isLoading.value;
          final contacts = controller.contacts.value;
          final selectedContact = controller.selectedContact.value;
          if (selectedContact != null) {
            WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
              Get.toNamed(
                ScreenPaths.chatPage,
                arguments: ChatPageArgs(
                  conversationId: controller.conversationId.value ?? '',
                  mate: controller.selectedContact.value?.username ?? '',
                  profileImage:
                      controller.selectedContact.value?.profileImage ?? '',
                ),
              )?.then((value) {
                if (value == null) {
                  controller.selectedContact.value = null;
                  contactsController.fetchContacts();
                }
              });
            });
          }
          if (isLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (contacts.isNotEmpty) {
            return ListView.builder(
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Column(
                  children: [
                    ListTile(
                      title: Text(
                        contact.username,
                        style: sty.text.t1Regular.copyWith(
                          color: sty.colors.tipBg,
                        ),
                      ),
                      subtitle: Text(
                        contact.email,
                        style: sty.text.t1Regular.copyWith(
                          color: sty.colors.tipBg,
                        ),
                      ),
                      onTap: () {
                        ///新建对话
                        contactsController.checkOrCreateConversation(
                          contact.id,
                          contact,
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Divider(height: 1.3, color: sty.colors.tipBg),
                    ),
                  ],
                );
              },
            );
          } else if (controller.error.value.isNotEmpty) {
            return Center(child: Text(controller.error.value));
          }
          return Center(child: Text('No contacts found'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddContactDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showAddContactDialog(BuildContext context) {
    final emailController = TextEditingController();

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            title: Text(
              str.addContact,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            content: TextField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: str.enterContactEmail,
                hintStyle: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  str.cancel,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
              TextButton(
                onPressed: () {
                  final email = emailController.text.trim();
                  if (email.isNotEmpty) {
                    contactsController.addContact(email);
                    Get.back();
                  }
                },
                child: Text(str.add),
              ),
            ],
          ),
    );
  }
}
