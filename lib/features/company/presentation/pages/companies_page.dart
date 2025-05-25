import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;

import 'package:mutazan_plus/core/connection/network_info.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/core/functions/navigation.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/core/widgets/show_top_snack_bar.dart';
import 'package:mutazan_plus/features/company/presentation/cubit/company_cubit.dart';
import 'package:mutazan_plus/features/company/presentation/cubit/company_state.dart';
import 'package:responsive_framework/responsive_framework.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({super.key});

  @override
  State<CompaniesPage> createState() => _CompaniesPageState();
}

class _CompaniesPageState extends State<CompaniesPage> {
  bool _hasFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasFetched) {
      context.read<CompanyCubit>().fetchCompanies();
      _hasFetched = true;
    }
  }

  Future<void> _onRefresh() async {
    final connected = await getIt<NetworkInfo>().isConnected;
    if (!connected) {
      showTopSnackBar(
        context,
        message: AppStrings.noInternet.tr,
        backgroundColor: AppColors.warning,
      );
      return;
    }
    await context.read<CompanyCubit>().fetchCompanies();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final overlay = SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: AppColors.backgroundColorAppBar,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.dark,
    );

    // Responsive paddings
    final horizontalPad = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 8,
      conditionalValues: [
        responsive.Condition.largerThan(name: MOBILE, value: 24),
        responsive.Condition.largerThan(name: TABLET, value: 32),
      ],
    ).value;

    final verticalPad = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 5,
      conditionalValues: [
        responsive.Condition.largerThan(name: MOBILE, value: 16),
        responsive.Condition.largerThan(name: TABLET, value: 24),
      ],
    ).value;

    final avatarRadius = ResponsiveValue<double>(
      context,
      defaultValue: 32,
      conditionalValues: [
        responsive.Condition.largerThan(name: MOBILE, value: 40),
        responsive.Condition.largerThan(name: TABLET, value: 48),
      ],
    ).value;

    final highlightBackground = theme.colorScheme.primary.withOpacity(0.2);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlay,
      child: RefreshIndicator(
        onRefresh: _onRefresh,
        backgroundColor: AppColors.primaryBackgroundColor!,
        color: AppColors.primaryColor,
        child: BlocConsumer<CompanyCubit, CompanyState>(
          listener: (context, state) {
            if (state is CompanyFailure) {
              showTopSnackBar(
                context,
                message: state.message,
                backgroundColor: AppColors.error,
              );
            }
          },
          builder: (context, state) {
            if (state is CompanyLoading) {
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            }
            if (state is CompanyFailure) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.wifi_off, size: 64, color: AppColors.error),
                    SizedBox(height: verticalPad),
                    Text(state.message,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium),
                    SizedBox(height: verticalPad),
                    ElevatedButton(
                      onPressed: _onRefresh,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: Text(AppStrings.retry.tr,
                          style: theme.textTheme.labelLarge!
                              .copyWith(color: AppColors.buttomColor)),
                    ),
                  ],
                ),
              );
            }

            final list = (state as CompanySuccess).companies;
            if (list.isEmpty) {
              return Center(
                child: Text(AppStrings.noCompanies.tr,
                    style: theme.textTheme.bodyMedium),
              );
            }

            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(vertical: verticalPad),
              itemCount: list.length,
              itemBuilder: (_, i) {
                final c = list[i];
                final rawLogo = c.logo;
                final logoUrl = rawLogo.startsWith('http')
                    ? rawLogo
                    : '${EndPoint.baseUrl}$rawLogo';
                final isActive = c.active == 'false';

                return Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: horizontalPad, vertical: verticalPad / 2),
                  child: Card(
                    color: isDark ? theme.canvasColor : theme.cardColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    elevation: 4,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap: () {
                        CacheHelper()
                            .saveData(key: ApiKey.xSchema, value: c.schemaName);
                        customNavigat(context, '/invoices', extra: {
                          'companyName': c.companyName,
                          'companyImag': logoUrl,
                        });
                      },
                      child: ListTile(
                        contentPadding: EdgeInsets.all(verticalPad),
                        leading: CircleAvatar(
                          radius: avatarRadius,
                          backgroundColor: AppColors.lightGrey,
                          backgroundImage: NetworkImage(logoUrl),
                        ),
                        title: Text(
                          c.companyName,
                          style: theme.textTheme.titleMedium!
                              .copyWith(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          isActive
                              ? AppStrings.active.tr
                              : AppStrings.inactive.tr,
                          style: theme.textTheme.bodySmall!.copyWith(
                              color: isActive
                                  ? AppColors.success
                                  : AppColors.error),
                        ),
                        trailing: Icon(
                          isActive ? Icons.check_circle : Icons.cancel,
                          color: isActive ? AppColors.success : AppColors.error,
                          size: avatarRadius,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

// // lib/features/company/presentation/pages/companies_page.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mutazan_plus/core/databases/api/end_points.dart';
// import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
// import 'package:mutazan_plus/core/connection/network_info.dart';
// import 'package:mutazan_plus/core/services/services_locator.dart';
// import 'package:mutazan_plus/features/company/presentation/cubit/company_cubit.dart';
// import 'package:mutazan_plus/features/company/presentation/cubit/company_state.dart';
// import '../../../../../core/utils/app_strings.dart';

// class CompaniesPage extends StatefulWidget {
//   const CompaniesPage({Key? key}) : super(key: key);

//   @override
//   State<CompaniesPage> createState() => _CompaniesPageState();
// }

// class _CompaniesPageState extends State<CompaniesPage> {
//   bool _hasFetched = false;

//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     if (!_hasFetched) {
//       context.read<CompanyCubit>().fetchCompanies();
//       _hasFetched = true;
//     }
//   }

//   Future<void> _onRefresh() async {
//     final networkInfo = getIt<NetworkInfo>();
//     final connected = await networkInfo.isConnected;
//     if (!connected) {
//       // إذا غير متصل، نظهر Snackbar ثم نكزّل إغلاق الـ RefreshIndicator
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('لا يوجد اتصال بالإنترنت')),
//       );
//       return;
//     }
//     // إذا متصل، نعيد جلب البيانات
//     await context.read<CompanyCubit>().fetchCompanies();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<CompanyCubit, CompanyState>(
//       listener: (context, state) {
//         if (state is CompanyFailure) {
//           ScaffoldMessenger.of(context)
//               .showSnackBar(SnackBar(content: Text(state.message)));
//         }
//       },
//       builder: (context, state) {
//         if (state is CompanyLoading) {
//           return const Center(child: CircularProgressIndicator());
//         }

//         if (state is CompanySuccess) {
//           final list = state.companies;
//           if (list.isEmpty) {
//             return const Center(child: Text('لا توجد شركات متاحة.'));
//           }
//           return RefreshIndicator(
//             onRefresh: _onRefresh,
//             child: ListView.builder(
//               physics: const AlwaysScrollableScrollPhysics(),
//               itemCount: list.length,
//               itemBuilder: (_, i) {
//                 final c = list[i];
//                 return Card(
//                   margin:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: ListTile(
//                     onTap: () {
//                       CacheHelper().saveData(
//                         key: ApiKey.xSchema,
//                         value: c.schemaName,
//                       );
//                       GoRouter.of(context).push('/invoices');
//                     },
//                     leading: CircleAvatar(
//                       backgroundImage: NetworkImage(c.logo),
//                       onBackgroundImageError: (_, __) {},
//                     ),
//                     title: Text(c.companyName),
//                     subtitle: Text(
//                       c.active == 'true'
//                           ? AppStrings.active
//                           : AppStrings.inactive,
//                       style: TextStyle(
//                         color: c.active == 'true' ? Colors.green : Colors.red,
//                       ),
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         }

//         if (state is CompanyFailure) {
//           return Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
//                 const SizedBox(height: 16),
//                 Text(state.message, textAlign: TextAlign.center),
//                 const SizedBox(height: 16),
//                 ElevatedButton(
//                   onPressed: _onRefresh,
//                   child: const Text('إعادة المحاولة'),
//                 ),
//               ],
//             ),
//           );
//         }

//         return const SizedBox.shrink();
//       },
//     );
//   }
// }
