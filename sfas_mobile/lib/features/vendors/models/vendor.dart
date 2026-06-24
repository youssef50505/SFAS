class Vendor {
  final String id;
  final String name;
  final String contactEmail;
  final String phoneNumber;
  final String taxId;
  final String address;

  Vendor({
    required this.id,
    required this.name,
    required this.contactEmail,
    required this.phoneNumber,
    required this.taxId,
    required this.address,
  });

  factory Vendor.fromJson(Map<String, dynamic> json) {
    return Vendor(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      contactEmail: json['contactEmail'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      taxId: json['taxId'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contactEmail': contactEmail,
      'phoneNumber': phoneNumber,
      'taxId': taxId,
      'address': address,
    };
  }
}
