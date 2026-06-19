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
import 'presentation/features/auth/bloc/auth_bloc.dart';
import 'presentation/features/dashboard/bloc/dashboard_bloc.dart';
import 'presentation/features/dashboard/bloc/dashboard_event.dart';

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
