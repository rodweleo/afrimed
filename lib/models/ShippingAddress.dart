class ShippingAddress {
  final String accountId;
  final String address;
  final String city;
  final String county;
  final String postalCode;

  ShippingAddress(
      {
        required this.accountId,
        required this.address,
      required this.city,
      required this.county,
      required this.postalCode});

  factory ShippingAddress.fromMap(Map<String, dynamic> map) {
    return ShippingAddress(
      accountId: map['accountId'],
      address: map['address'],
      city: map['city'],
      county: map['county'],
      postalCode: map['postalCode'],
    );
  }
}
