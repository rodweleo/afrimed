class ShippingAddress {
  final String address;
  final String town;
  final String county;


  ShippingAddress(
      {
        required this.address,
      required this.county,
      required this.town});

  factory ShippingAddress.fromMap(Map<String, dynamic> map) {
    return ShippingAddress(
      address: map['address'],
      county: map['county'],
      town: map['town'],
    );
  }
}
