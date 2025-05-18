class TransactionExceptions implements Exception {
  final String message;

  TransactionExceptions(this.message);

  @override
  String toString() {
    return message;
  }
}
