import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:remixicon/remixicon.dart';
import '../../../../data/repositories/bill_repository.dart';
import '../../../../data/repositories/fund_repository.dart';
import '../../../../data/repositories/collection_repository.dart';
import '../../../../data/repositories/vendor_repository.dart';
import '../../../../domain/models/bill.dart';
import '../../../../domain/models/fund.dart';
import '../../../../domain/models/collection.dart';
import '../../../../domain/models/vendor.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final FundRepository _fundRepository;
  final BillRepository _billRepository;
  final CollectionRepository _collectionRepository;
  final VendorRepository _vendorRepository;

  DashboardBloc({
    required FundRepository fundRepository,
    required BillRepository billRepository,
    required CollectionRepository collectionRepository,
    required VendorRepository vendorRepository,
  })  : _fundRepository = fundRepository,
        _billRepository = billRepository,
        _collectionRepository = collectionRepository,
        _vendorRepository = vendorRepository,
        super(const DashboardState.initial()) {
    on<DashboardEvent>((event, emit) async {
      await event.map(
        loadDashboardData: (e) => _onLoadDashboardData(emit),
      );
    });
  }

  Future<void> _onLoadDashboardData(Emitter<DashboardState> emit) async {
    emit(const DashboardState.loading());
    try {
      final results = await Future.wait([
        _fundRepository.getFunds(),
        _billRepository.getBills(),
        _collectionRepository.getCollections(),
        _vendorRepository.getVendors(),
      ]);

      final funds = results[0] as List<Fund>;
      final bills = results[1] as List<Bill>;
      final collections = results[2] as List<Collection>;
      final vendors = results[3] as List<Vendor>;

      // 1. Total Funds (Approved)
      double totalFunds = 0;
      int pendingFundsCount = 0;
      for (var f in funds) {
        if (f.status == 'APPROVED') {
          totalFunds += f.amountOfFund;
        } else if (f.status == 'PENDING') {
          pendingFundsCount++;
        }
      }

      // 2. Pending Bills
      int pendingBillsCount = 0;
      for (var b in bills) {
        if (b.status == 'PENDING') {
          pendingBillsCount++;
        }
      }

      // 3. Monthly Revenue
      double monthlyRevenue = 0;
      final now = DateTime.now();
      for (var c in collections) {
        final date = DateTime.tryParse(c.date);
        if (date != null && date.year == now.year && date.month == now.month) {
          monthlyRevenue += c.amount;
        }
      }

      // 4. Active Vendors
      int activeVendorsCount = vendors.length;

      // 5. Recent Activity
      List<ActivityItem> activities = [];
      for (var b in bills) {
        if (b.status != 'PENDING') {
          activities.add(ActivityItem(
            title: b.status == 'APPROVED' ? 'Bill Approved' : 'Bill Rejected',
            subtitle: 'Vendor: ${b.vendor?.name ?? "Unknown"} - ${b.amount} EGP',
            date: DateTime.tryParse(b.updatedAt ?? b.createdAt ?? '') ?? DateTime.now(),
            icon: b.status == 'APPROVED' ? Remix.check_line : Remix.close_line,
            color: b.status == 'APPROVED' ? Colors.green : Colors.red,
          ));
        }
      }
      for (var f in funds) {
        if (f.status != 'PENDING') {
          activities.add(ActivityItem(
            title: f.status == 'APPROVED' ? 'Fund Approved' : 'Fund Rejected',
            subtitle: '${f.title} - ${f.amountOfFund} EGP',
            date: DateTime.tryParse(f.updatedAt ?? f.createdAt ?? '') ?? DateTime.now(),
            icon: f.status == 'APPROVED' ? Remix.check_line : Remix.close_line,
            color: f.status == 'APPROVED' ? Colors.green : Colors.red,
          ));
        }
      }

      activities.sort((a, b) => b.date.compareTo(a.date));
      final recentActivities = activities.take(5).toList();

      emit(DashboardState.loaded(
        totalFunds: totalFunds,
        pendingBillsCount: pendingBillsCount,
        monthlyRevenue: monthlyRevenue,
        activeVendorsCount: activeVendorsCount,
        pendingFundsCount: pendingFundsCount,
        recentActivities: recentActivities,
      ));
    } catch (e) {
      emit(DashboardState.error(e.toString()));
    }
  }
}
