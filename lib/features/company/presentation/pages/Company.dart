import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/features/company/presentation/pages/companies_page.dart';
import 'package:mutazan_plus/core/widgets/container_radius.dart';
import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';

class CompanyPage extends StatelessWidget {
  const CompanyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        centerTitle: true, // لمحاذاة العنوان في المنتصف
        title: Text(
          AppStrings.companies.tr,
          style: theme.textTheme.headlineSmall!
              .copyWith(color: Colors.white, fontWeight: FontWeight.w900),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ContainerRadius(
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16.0,
                  top: 20.0,
                ),
                child: const CompaniesPage(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BlocBuilder<NavCubit, int>(
        builder: (context, selectedIndex) {
          return Container(
            color:Theme.of(context).canvasColor,
            child: NavigationBarItems(
              showBarcode: false,
            ),
          );
        },
      ),
    );
  }
}