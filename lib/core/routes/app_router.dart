// router.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/features/auth/presentation/views/sign_in_view.dart';
import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:mutazan_plus/features/invoice/presentation/pages/filtered_invoices_page.dart';
import 'package:mutazan_plus/features/invoice/presentation/pages/invoice_page.dart';
import 'package:mutazan_plus/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:mutazan_plus/features/splash/presentation/views/splash_view.dart';
import 'package:mutazan_plus/features/company/presentation/pages/Company.dart';
import 'package:mutazan_plus/features/home/presentation/views/home_screen.dart';
import 'package:mutazan_plus/features/view/Notifications.dart';
import 'package:mutazan_plus/features/view/Settings.dart';
import 'package:mutazan_plus/features/view/profile_page.dart';

final GoRouter router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(path: "/", builder: (context, state) => const SplashView()),
    GoRoute(
      path: "/onBoarding",
      builder: (context, state) => const OnBoardingView(),
    ),
    GoRoute(path: "/signIn", builder: (context, state) => const SignInView()),
    // GoRoute(
    //   path: '/homeView',
    //   pageBuilder: (context, state) {
    //     return MaterialPage(
    //       key: state.pageKey,
    //       child: const Home(),
    //     );
    //   },
    // ),
    // router.dart
GoRoute(
  path: '/homeView',
  pageBuilder: (context, state) {
    final cubit = getIt<InvoiceCubit>();
    // لا تستدعي fetchInvoices هنا
    return MaterialPage(
      key: state.pageKey,
      child: BlocProvider.value(
        value: cubit,
        child: const Home(), // Home ستتعامل هي مع fetchInvoices
      ),
    );
  },
),


    GoRoute(path: '/companies', builder: (c, s) => const CompanyPage()),
    GoRoute(path: '/profile', builder: (c, s) => const ProfilePage1()),
    GoRoute(path: '/settings', builder: (c, s) => const SettingsPage()),
    GoRoute(path: '/notifications', builder: (c, s) => const Notifications()),
    GoRoute(
      path: '/invoices',
      builder: (context, state) {
        // نتوقع extra عبارة عن Map<String, String>
        final args = state.extra as Map<String, String>? ?? {};
        return InvoicesPage(
          companyName: args['companyName'] ?? '',
          companyImag: args['companyImag'] ?? '',
        );
      },
    ),
    GoRoute(
      path: '/filtered-invoices',
      builder: (context, state) {
        final args = state.extra as Map<String, dynamic>? ?? {};
        return FilteredInvoicesPage(
          title: args['title'] ?? '',
          showPending: args['showPending'] ?? false,
        );
      },
    ),
  ],
);
