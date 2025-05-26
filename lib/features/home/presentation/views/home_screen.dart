import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/features/company/presentation/cubit/company_cubit.dart';
import 'package:mutazan_plus/features/company/presentation/pages/companies_page.dart';
import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/widgets/container_radius.dart';
import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
import 'package:mutazan_plus/features/home/presentation/widgets/StatsRowWidget.dart';
import 'package:mutazan_plus/features/home/presentation/widgets/header_widget.dart';
import 'package:mutazan_plus/features/home/presentation/widgets/footer_widget.dart';
import 'package:mutazan_plus/features/home/presentation/widgets/header_row_widget.dart';
import 'package:mutazan_plus/features/home/presentation/widgets/StatsWidget.dart';
import 'package:responsive_framework/responsive_framework.dart' as resp;
import 'package:responsive_framework/responsive_framework.dart';

class Home extends StatefulWidget {
  const Home({super.key});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
final horizontalPadding = resp.ResponsiveValue<double>(
      context,
      defaultValue: 16,
      conditionalValues: [
        resp.Condition.largerThan(name: resp.MOBILE, value: 24),
        resp.Condition.largerThan(name: resp.TABLET, value: 32),
      ],
    ).value;

    final verticalSpacing = resp.ResponsiveValue<double>(
      context,
      defaultValue: 12,
      conditionalValues: const [
        Condition.largerThan(name: MOBILE, value: 16),
        resp.Condition.largerThan(name: TABLET, value: 24),
      ],
    ).value;

    final circleRadius = resp.ResponsiveValue<double>(
      context,
      defaultValue: 8,
      conditionalValues: const [
        resp.Condition.largerThan(name: resp.MOBILE, value: 10),
        resp.Condition.largerThan(name: resp.TABLET, value: 12),
      ],
    ).value;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        title: const HeaderWidget(),
        actions: [
          StreamBuilder<DataConnectionStatus>(
            stream: DataConnectionChecker().onStatusChange,
            builder: (ctx, snap) {
              final ok = snap.data == DataConnectionStatus.connected;
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: CircleAvatar(
                  radius: circleRadius,
                  backgroundColor: ok ? AppColors.success : AppColors.error,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            SizedBox(height: verticalSpacing),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: const StatsWidget(),
            ),
            SizedBox(height: verticalSpacing),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
              child: const FooterWidget(),
            ),
            SizedBox(height: verticalSpacing * 0.5),
            Expanded(
              child: ContainerRadius(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: verticalSpacing * 0.5,
                    left: horizontalPadding,
                    right: horizontalPadding,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: verticalSpacing),
                      const StatsRowWidget(),
                      SizedBox(height: verticalSpacing),
                      const HeaderRowWidget(),
                      SizedBox(height: verticalSpacing * 0.5),
                      Expanded(
                        child: BlocProvider<CompanyCubit>(
                          create: (_) =>
                              getIt<CompanyCubit>()..fetchCompanies(),
                          child: const CompaniesPage(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BlocBuilder<NavCubit, int>(
        builder: (context, selectedIndex) {
          return Container(
            color: Theme.of(context).canvasColor,
            child: const NavigationBarItems(showBarcode: false),
          );
        },
      ),
    );
  }
}
