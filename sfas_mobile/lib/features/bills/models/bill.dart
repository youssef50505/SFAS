import '../../vendors/models/vendor.dart';

class Bill {
  final String id;
  final String invoiceNumber;
  final String date;
  final double amount;
  final String description;
  final String status;
  final Vendor vendor;

  Bill({
    required this.id,
    required this.invoiceNumber,
    required this.date,
    required this.amount,
    required this.description,
    required this.status,
    required this.vendor,
  });

  factory Bill.fromJson(Map<String, dynamic> json) {
    return Bill(
      id: json['id'] ?? '',
      invoiceNumber: json['title'] ?? '',
      date: json['date'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      description: json['description'] ?? '',
      status: json['status'] ?? 'PENDING',
      vendor: json['vendor'] != null 
          ? Vendor.fromJson(json['vendor']) 
          : Vendor(id: '', name: 'Unknown', contactEmail: '', phoneNumber: '', taxId: '', address: ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': invoiceNumber,
      'date': date,
      'amount': amount,
      'description': description,
      'status': status,
      'vendorId': vendor.id,
    };
  }
}
