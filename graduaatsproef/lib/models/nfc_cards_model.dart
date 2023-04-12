class NfcCards {
  final int card_id;
  final int user_Id;
  final String card_Uid;
  final String? encryption_Key;
  final DateTime createdAt;
  final DateTime updatedAt;

  NfcCards({
    required this.card_id,
    required this.user_Id,
    required this.card_Uid,
    required this.encryption_Key,
    required this.createdAt,
    required this.updatedAt,
  });

  factory NfcCards.fromJson(Map<String, dynamic> json) {
    return NfcCards(
      card_id: json['card_id'],
      user_Id: json['user_id'],
      card_Uid: json['card_uid'],
      encryption_Key: json['encryption_key'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
