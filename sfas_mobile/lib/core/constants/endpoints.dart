class Endpoints {
  // Use 10.0.2.2 for Android emulator to access host localhost
  static const String baseUrl = 'http://10.0.2.2:8080/api/v1';

  // Auth
  static const String login = '/auth/login';

  // Vendors
  static const String vendors = '/vendors';
  static String vendorDetails(String id) => '/vendors/$id';

  // Bills
  static const String bills = '/bills';
  static String billDetails(String id) => '/bills/$id';
  static String updateBillStatus(String id) => '/bills/$id/status';

  // Funds
  static const String funds = '/funds';
  static String updateFundStatus(String id) => '/funds/$id/status';

  // Items
  static const String items = '/items';
  static String itemDetails(String id) => '/items/$id';

  // Reports
  static const String reports = '/reports';

  // Notifications
  static const String notifications = '/notifications';

  // Collections
  static const String collectionsMetrics = '/collections/metrics';
}
