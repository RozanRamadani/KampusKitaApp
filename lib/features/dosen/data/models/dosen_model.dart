class DosenModel {
  final int id;
  final String name;
  final String username;
  final String email;
  final Address address;

  DosenModel({
    required this.id,
    required this.name,
    required this.username,
    required this.email,
    required this.address,
  });

  factory DosenModel.fromJson(Map<String, dynamic> json) {
    return DosenModel(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
      address: Address.fromJson(json['address']),
    );
  }
}

class Address {
  final String city;
  final String street; // Tambahkan ini

  Address({required this.city, required this.street});

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'] ?? '',
      street: json['street'] ?? '',
    );
  }
}
