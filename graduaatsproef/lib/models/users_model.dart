class Users {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? address;
  final String? city;
  final String? zipcode;
  final String? country;
  final String? phone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final bool checkedIn;

  Users({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.address,
    required this.city,
    required this.zipcode,
    required this.country,
    required this.phone,
    required this.createdAt,
    required this.updatedAt,
    required this.checkedIn,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['user_id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      checkedIn: json['checked_in'],
      address: json['address'],
      city: json['city'],
      zipcode: json['zip_code'],
      country: json['country'],
      phone: json['phone'],
    );
  }

  factory Users.fromMap(Map<String, dynamic> map) {
    return Users(
      id: map['user_id'],
      firstName: map['first_name'],
      lastName: map['last_name'],
      email: map['email'],
      address: map['address'],
      city: map['city'],
      zipcode: map['zip_code'],
      country: map['country'],
      phone: map['phone'],
      createdAt: DateTime.parse(map['created_at']),
      updatedAt: DateTime.parse(map['updated_at']),
      checkedIn: map['checked_in'],
    );
  }
}
