class Account {
  late String? id;
  late String name;
  late String role;
  late Contact contact;
  late Location location;
  late BusinessInfo businessInfo;
  late bool hasUploadedIdentificationDocuments;
  late bool isVerified;
  late String imageUrl;

  Account({
    required this.id,
    required this.name,
    required this.role,
    required this.contact,
    required this.location,
    required this.businessInfo,
    required this.hasUploadedIdentificationDocuments,
    required this.isVerified,
    required this.imageUrl,
});

  factory Account.fromMap(String id,Map<String, dynamic> map) {
    return Account(
      id: map['id'],
      name: map['name'],
      role: map['role'],
      businessInfo: BusinessInfo.fromMap(map['businessInformation']),
      contact: Contact.fromMap(map['contact']),
      location: Location.fromMap(map['location']),
      hasUploadedIdentificationDocuments: map['hasUploadedIdentificationDocuments'] ?? false,
      isVerified : map['isVerified'] ?? false,
      imageUrl: map['imageUrl'],
    );
  }
}

class Contact {
  final String email;
  final int phoneNumber;

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
    return {
      'county': county,
      'town': town,
      'address': address
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      county: map['county'],
      town: map['town'],
      address: map['address']
    );
  }
}

class BusinessInfo {
  final String businessCategory;
  final String businessName;

  BusinessInfo({required this.businessCategory, required this.businessName});

  Map<String, dynamic> toMap() {
    return {
      'businessCategory': businessCategory,
      'businessName': businessName,
    };
  }

  factory BusinessInfo.fromMap(Map<String, dynamic> map) {
    return BusinessInfo(
      businessCategory: map['businessCategory'],
      businessName: map['businessName'],
    );
  }
}
