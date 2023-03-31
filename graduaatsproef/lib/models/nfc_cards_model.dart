class NfcCards {
  final int id;
  final int userId;
  final String cardUid;
  final String encryptionKey;
  final DateTime createdAt;
  final DateTime updatedAt;

  NfcCards({
    required this.id,
    required this.userId,
    required this.cardUid,
    required this.encryptionKey,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NfcCards.fromJson(Map<String, dynamic> json) {
    return NfcCards(
      id: json['card_id'],
      userId: json['user_id'],
      cardUid: json['card_uid'],
      encryptionKey: json['encryption_key'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
