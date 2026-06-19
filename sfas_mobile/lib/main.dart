import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/theme/app_theme.dart';
import 'core/routes/app_router.dart';
import 'core/security/secure_storage.dart';
import 'core/network/dio_client.dart';
import 'data/repositories/auth_repository.dart';
import 'data/repositories/bill_repository.dart';
import 'data/repositories/fund_repository.dart';
import 'data/repositories/collection_repository.dart';
import 'data/repositories/vendor_repository.dart';
import 'data/repositories/report_repository.dart';
import 'data/repositories/notification_repository.dart';
import 'presentation/features/auth/bloc/auth_bloc.dart';
import 'presentation/features/dashboard/bloc/dashboard_bloc.dart';
import 'presentation/features/dashboard/bloc/dashboard_event.dart';
import 'presentation/features/bills/bloc/bills_bloc.dart';
import 'presentation/features/bills/bloc/bills_event.dart';
import 'presentation/features/funds/bloc/funds_bloc.dart';
import 'presentation/features/funds/bloc/funds_event.dart';
import 'presentation/features/collections/bloc/collections_bloc.dart';
import 'presentation/features/collections/bloc/collections_event.dart';
import 'presentation/features/reports/bloc/reports_bloc.dart';
import 'presentation/features/reports/bloc/reports_event.dart';
import 'presentation/features/notifications/bloc/notifications_bloc.dart';
import 'presentation/features/notifications/bloc/notifications_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SecureStorage>(
          create: (context) => SecureStorage(),
        ),
        RepositoryProvider<DioClient>(
          create: (context) => DioClient(context.read<SecureStorage>()),
        ),
        RepositoryProvider<AuthRepository>(
          create: (context) => AuthRepository(
            context.read<DioClient>(),
            context.read<SecureStorage>(),
          ),
        ),
        RepositoryProvider<BillRepository>(
          create: (context) => BillRepository(context.read<DioClient>()),
        ),
        RepositoryProvider<FundRepository>(
          create: (context) => FundRepository(context.read<DioClient>()),
        ),
        RepositoryProvider<CollectionRepository>(
          create: (context) => CollectionRepository(context.read<DioClient>()),
        ),
        RepositoryProvider<VendorRepository>(
          create: (context) => VendorRepository(context.read<DioClient>()),
        ),
        RepositoryProvider<ReportRepository>(
          create: (context) => ReportRepository(context.read<DioClient>()),
        ),
        RepositoryProvider<NotificationRepository>(
          create: (context) => NotificationRepository(context.read<DioClient>()),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(context.read<AuthRepository>()),
          ),
          BlocProvider<DashboardBloc>(
            create: (context) => DashboardBloc(
              fundRepository: context.read<FundRepository>(),
              billRepository: context.read<BillRepository>(),
              collectionRepository: context.read<CollectionRepository>(),
              vendorRepository: context.read<VendorRepository>(),
            )..add(const DashboardEvent.loadDashboardData()),
          ),
          BlocProvider<BillsBloc>(
            create: (context) => BillsBloc(billRepository: context.read<BillRepository>())..add(const BillsEvent.loadBills()),
          ),
          BlocProvider<FundsBloc>(
            create: (context) => FundsBloc(fundRepository: context.read<FundRepository>())..add(const FundsEvent.loadFunds()),
          ),
          BlocProvider<CollectionsBloc>(
            create: (context) => CollectionsBloc(collectionRepository: context.read<CollectionRepository>())..add(const CollectionsEvent.loadCollections()),
          ),
          BlocProvider<ReportsBloc>(
            create: (context) => ReportsBloc(reportRepository: context.read<ReportRepository>())..add(const ReportsEvent.loadReports()),
          ),
          BlocProvider<NotificationsBloc>(
            create: (context) => NotificationsBloc(notificationRepository: context.read<NotificationRepository>())..add(const NotificationsEvent.loadNotifications()),
          ),
        ],
        child: MaterialApp.router(
          title: 'SFAS',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: ThemeMode.system,
          routerConfig: AppRouter.router,
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
