class Account {
  late String id;
  late String name;
  late String role;
  late Contact contact;
  late Location location;
  late String businessName;
  late bool hasUploadedIdentificationDocuments;
  late bool isVerified;
  late String imageUrl;
  late String username;
  late String password;
  Account(
      {required this.id,
      required this.name,
      required this.role,
      required this.contact,
      required this.location,
      required this.businessName,
      required this.hasUploadedIdentificationDocuments,
      required this.isVerified,
      required this.imageUrl,
      required this.username,
      required this.password});

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
        id: map['id'],
        name: map['name'],
        role: map['role'],
        businessName: map['businessName'],
        contact: Contact.fromMap(map['contact']),
        location: Location.fromMap(map['location']),
        hasUploadedIdentificationDocuments:
            map['hasUploadedIdentificationDocuments'] ?? false,
        isVerified: map['isVerified'] ?? false,
        imageUrl: map['imageUrl'],
        username: map['username'],
        password: map['password']);
  }
}

class Contact {
  final String email;
  final String phoneNumber;

  Contact({required this.email, required this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'phoneNumber': phoneNumber,
    };
  }

  factory Contact.fromMap(Map<String, dynamic> map) {
    return Contact(
      email: map['email'],
      phoneNumber: map['phoneNumber'],
    );
  }
}

class Location {
  final String county;
  final String town;
  final String address;

  Location({required this.county, required this.town, required this.address});

  Map<String, dynamic> toMap() {
    return {'county': county, 'town': town, 'address': address};
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
        county: map['county'], town: map['town'], address: map['address']);
  }
}
