import 'package:preview_play/src/features/data/models/contacts_model.dart';
import 'package:preview_play/src/features/data/repositories/conversations_repository_impl.dart';
import 'package:preview_play/utils/network/http_util.dart';

import '../../../../constants/common_libs.dart';
import '../../data/repositories/contacts_repository_impl.dart';
import 'conversations_controller.dart';

class ContactsController extends GetxController {
  final ContactsRepositoryImpl contactsRepositoryImpl = sl();
  final ConversationsRepositoryImpl conversationsRepositoryImpl = sl();

  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;
  final RxList<ContactsModel> contacts = <ContactsModel>[].obs;
  final RxList recentContacts = [].obs;
  final Rxn<String> conversationId = Rxn<String>();
  final Rxn<ContactsModel?> selectedContact = Rxn<ContactsModel?>();

  ContactsController();

  final ConversationsController conversationsController =
      Get.find<ConversationsController>();

  @override
  void onInit() {
    super.onInit();
    loadRecentContacts();
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    isLoading.value = true;
    error.value = '';

    try {
      final result = await contactsRepositoryImpl.fetchContacts();
      contacts.value = result ?? [];
    } catch (e) {
      error.value = 'Failed to fetch contacts';
    } finally {
      isLoading.value = false;
      refresh();
    }
  }

  Future<void> addContact(String email) async {
    isLoading.value = true;
    error.value = '';

    try {
      await contactsRepositoryImpl.addContact(email: email);
      // 重新加载联系人列表
      await fetchContacts();
      // 重新加载最近联系人列表
      await loadRecentContacts();
      // 重新加载对话列表
      await conversationsController.fetchConversations();
      refresh();
    } catch (e) {
      //'Failed to add contact'
      error.value = e.toString();
      ToastV2.show(error.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadRecentContacts() async {
    isLoading.value = true;
    error.value = '';

    try {
      final result = await contactsRepositoryImpl.getRecentContacts() ?? [];
      recentContacts.value = result;
    } catch (e) {
      error.value = e.toString();
      ToastV2.show(error.value);
      // error.value = 'Failed to load recent contacts';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkOrCreateConversation(
    String contactId,
    ContactsModel contact,
  ) async {
    isLoading.value = true;
    error.value = '';

    try {
      final result = await conversationsRepositoryImpl
          .checkOrCreateConversation(contactId: contactId);
      conversationId.value = result;
      selectedContact.value = contact;
    } catch (e) {
      error.value = 'Failed to start conversation';
    } finally {
      isLoading.value = false;
      refresh();
    }
  }
}
