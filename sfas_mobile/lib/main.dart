import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'core/constants/app_theme.dart';
import 'core/network/dio_client.dart';

import 'features/auth/services/auth_service.dart';
import 'features/auth/viewmodels/auth_viewmodel.dart';
import 'features/auth/views/login_screen.dart';

import 'features/collections/services/collection_service.dart';
import 'features/collections/viewmodels/collection_viewmodel.dart';
import 'features/dashboard/views/dashboard_screen.dart';
import 'features/dashboard/views/main_layout.dart';

import 'features/vendors/models/vendor.dart';
import 'features/vendors/services/vendor_service.dart';
import 'features/vendors/viewmodels/vendor_viewmodel.dart';
import 'features/vendors/views/vendors_list_screen.dart';
import 'features/vendors/views/vendor_form_screen.dart';

import 'features/bills/models/bill.dart';
import 'features/bills/services/bill_service.dart';
import 'features/bills/viewmodels/bill_viewmodel.dart';
import 'features/bills/views/bills_list_screen.dart';
import 'features/bills/views/bill_form_screen.dart';

import 'features/funds/services/fund_service.dart';
import 'features/funds/viewmodels/fund_viewmodel.dart';
import 'features/funds/views/funds_list_screen.dart';
import 'features/funds/views/fund_form_screen.dart';

import 'features/items/models/item.dart';
import 'features/items/services/item_service.dart';
import 'features/items/viewmodels/item_viewmodel.dart';
import 'features/items/views/items_list_screen.dart';
import 'features/items/views/item_form_screen.dart';

import 'features/reports/services/report_service.dart';
import 'features/reports/viewmodels/report_viewmodel.dart';
import 'features/reports/views/reports_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  const storage = FlutterSecureStorage();
  final dioClient = DioClient(storage: storage);
  final authService = AuthService(dioClient.dio);

  final authViewModel = AuthViewModel(
    authService: authService,
    storage: storage,
  );

  final collectionService = CollectionService(dioClient.dio);
  final collectionViewModel = CollectionViewModel(collectionService);

  final vendorService = VendorService(dioClient.dio);
  final vendorViewModel = VendorViewModel(vendorService);

  final billService = BillService(dioClient.dio);
  final billViewModel = BillViewModel(billService);

  final fundService = FundService(dioClient.dio);
  final fundViewModel = FundViewModel(fundService);

  final itemService = ItemService(dioClient.dio);
  final itemViewModel = ItemViewModel(itemService);

  final reportService = ReportService(dioClient.dio);
  final reportViewModel = ReportViewModel(reportService);

  // Check initial auth status
  await authViewModel.checkAuthStatus();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: authViewModel),
        ChangeNotifierProvider.value(value: collectionViewModel),
        ChangeNotifierProvider.value(value: vendorViewModel),
        ChangeNotifierProvider.value(value: billViewModel),
        ChangeNotifierProvider.value(value: fundViewModel),
        ChangeNotifierProvider.value(value: itemViewModel),
        ChangeNotifierProvider.value(value: reportViewModel),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();

    final router = GoRouter(
      initialLocation: authViewModel.currentUser == null ? '/login' : '/dashboard',
      redirect: (context, state) {
        final isLoggedIn = authViewModel.currentUser != null;
        final isLoggingIn = state.matchedLocation == '/login';

        if (!isLoggedIn && !isLoggingIn) return '/login';
        if (isLoggedIn && isLoggingIn) return '/dashboard';
        return null;
      },
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        ShellRoute(
          builder: (context, state, child) => MainLayout(child: child),
          routes: [
            GoRoute(
              path: '/dashboard',
              builder: (context, state) => const DashboardScreen(),
            ),
            GoRoute(
              path: '/vendors',
              builder: (context, state) => const VendorsListScreen(),
              routes: [
                GoRoute(
                  path: 'add',
                  builder: (context, state) => const VendorFormScreen(),
                ),
                GoRoute(
                  path: 'edit',
                  builder: (context, state) {
                    final vendor = state.extra as Vendor?;
                    return VendorFormScreen(vendor: vendor);
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/bills',
              builder: (context, state) => const BillsListScreen(),
              routes: [
                GoRoute(
                  path: 'add',
                  builder: (context, state) => const BillFormScreen(),
                ),
                GoRoute(
                  path: 'edit',
                  builder: (context, state) {
                    final bill = state.extra as Bill?;
                    return BillFormScreen(bill: bill);
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/funds',
              builder: (context, state) => const FundsListScreen(),
              routes: [
                GoRoute(
                  path: 'add',
                  builder: (context, state) => const FundFormScreen(),
                ),
              ],
            ),
            GoRoute(
              path: '/items',
              builder: (context, state) => const ItemsListScreen(),
              routes: [
                GoRoute(
                  path: 'add',
                  builder: (context, state) => const ItemFormScreen(),
                ),
                GoRoute(
                  path: 'edit',
                  builder: (context, state) {
                    final item = state.extra as Item?;
                    return ItemFormScreen(item: item);
                  },
                ),
              ],
            ),
            GoRoute(
              path: '/reports',
              builder: (context, state) => const ReportsScreen(),
            ),
          ],
        ),
      ],
    );

    return MaterialApp.router(
      title: 'SFAS Mobile',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: router,
    );
  }
}
