class Encryption {
  final int id;
  final String key;
  final String iv;
  final DateTime createdAt;

  Encryption({
    required this.id,
    required this.key,
    required this.iv,
    required this.createdAt,
  });

  factory Encryption.fromJson(Map<String, dynamic> json) {
    return Encryption(
      id: json['id'],
      key: json['key'],
      iv: json['iv'],
      createdAt: DateTime.parse(json['created_at']),
    );
  }
}
