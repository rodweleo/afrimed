
class Supplier {
  final String? id;
  final String name;
  final Contact contact;
  final Location location;
  final BusinessInfo businessInfo;
  final String imageUrl;
  Supplier(
      {
        required this.id,
      required this.businessInfo,
        required this.name,
      required this.contact,
      required this.location,
        required this.imageUrl,
      });



  factory Supplier.fromMap(String id,Map<String, dynamic> map) {
    return Supplier(
      id: id,
      name: map['name'],
      businessInfo: BusinessInfo.fromMap(map['businessInformation']),
      contact: Contact.fromMap(map['contact']),
      location: Location.fromMap(map['location']),
      imageUrl: map['imageUrl']
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
  final String estate;

  Location({required this.county, required this.estate});

  Map<String, dynamic> toMap() {
    return {
      'county': county,
      'estate': estate,
    };
  }

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      county: map['county'],
      estate: map['estate'],
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

