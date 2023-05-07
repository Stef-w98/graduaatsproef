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
}
