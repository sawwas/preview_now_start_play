
import 'package:preview_play/src/features/data/models/contacts_model.dart';

import '../../domain/repositories/contacts_repository.dart';
import '../api/contacts_api.dart';

class ContactsRepositoryImpl implements ContactsRepository {
  final ContactsApi contactsApi;

  ContactsRepositoryImpl({required this.contactsApi});

  @override
  Future<void> addContact({required String email}) async {
    await contactsApi.addContact(email: email);
  }

  @override
  Future<List<ContactsModel>?> fetchContacts() async {
    return await contactsApi.fetchContacts();
  }

  @override
  Future<List<ContactsModel>?> getRecentContacts() async {
    return await contactsApi.fetchRecentContacts();
  }
}
