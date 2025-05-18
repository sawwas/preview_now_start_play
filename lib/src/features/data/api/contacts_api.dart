import 'package:preview_play/src/features/data/models/contacts_model.dart';

import 'app_api.dart';

class ContactsApi {
  ContactsApi();

  Future<List<ContactsModel>?> fetchContacts() async {
    final response = await AppApi().get('contacts');
    if (response != null) {
      List data = response;

      List<ContactsModel> contactsList = [];
      for (var item in data) {
        contactsList.add(ContactsModel.fromJson(item as Map<String, dynamic>));
      }
      return contactsList;
    } else {
      throw Exception('Failed to fetch contacts');
    }
  }

  Future<void> addContact({required String email}) async {
    final response = await AppApi().post(
      'contacts',
      data: {'contactEmail': email},
    );
    //
    // if (response.code != 201) {
    //   throw Exception('Failed to add contact');
    // }
  }

  Future<List<ContactsModel>?> fetchRecentContacts() async {
    final response = await AppApi().get('contacts/recent');

    if (response != null) {
      List data = response;

      List<ContactsModel> contactsList = [];
      for (var item in data) {
        contactsList.add(ContactsModel.fromJson(item as Map<String, dynamic>));
      }
      return contactsList;
    } else {
      throw Exception('Failed to fetch recent contacts');
    }
  }
}
