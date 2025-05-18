import 'package:preview_play/src/features/data/models/contacts_model.dart';

abstract class ContactsRepository {
  Future<List<ContactsModel>?> fetchContacts();

  Future<void> addContact({required String email});

  Future<List<ContactsModel>?> getRecentContacts();
}
