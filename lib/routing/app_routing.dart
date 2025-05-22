import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:program_visit/features/admin/view/daftar_sales_view.dart';
import 'package:program_visit/features/admin/view/form/pendaftaran_sales_view.dart';
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
        return const HomeView();
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
  ],
);
