import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/features/admin/view/customer/daftar_customer_view.dart';
import 'package:program_visit/features/admin/view/customer/detail_customer_view.dart';
import 'package:program_visit/features/admin/view/customer/form/pendaftaran_customer_view.dart';
import 'package:program_visit/features/admin/view/sales/daftar_sales_view.dart';
import 'package:program_visit/features/admin/view/sales/detail_sales_view.dart';
import 'package:program_visit/features/admin/view/sales/form/pendaftaran_sales_view.dart';
import 'package:program_visit/features/admin/view/home_view.dart';
import 'package:program_visit/features/authentication/view/login_view.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: "/login",
  routes: <RouteBase>[
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) {
        return const LoginView();
      },
    ),
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return HomeView();
      },
    ),
    GoRoute(
      path: '/daftar-sales',
      builder: (BuildContext context, GoRouterState state) {
        return const DaftarSalesView();
      },
    ),

    GoRoute(
      path: '/pendaftaran-sales',
      builder: (BuildContext context, GoRouterState state) {
        return const PendaftaranSalesView();
      },
    ),
    GoRoute(
      path: '/detail-sales',
      builder: (BuildContext context, GoRouterState state) {
        return const DetailSalesView();
      },
    ),
    GoRoute(
      path: '/daftar-customer',
      builder: (BuildContext context, GoRouterState state) {
        return const DaftarCustomerView();
      },
    ),
    GoRoute(
      path: '/pendaftaran-customer',
      builder: (BuildContext context, GoRouterState state) {
        return const PendaftaranCustomerView();
      },
    ),
    GoRoute(
      path: '/detail-customer',
      builder: (BuildContext context, GoRouterState state) {
        return const DetailCustomerView();
      },
    ),
  ],
);
