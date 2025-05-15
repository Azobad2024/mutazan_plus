// lib/features/company/presentation/pages/companies_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mutazan_plus/core/connection/network_info.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/core/functions/navigation.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import '../cubit/company_cubit.dart';
import '../cubit/company_state.dart';

class CompaniesPage extends StatefulWidget {
  const CompaniesPage({Key? key}) : super(key: key);

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
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يوجد اتصال بالإنترنت')),
      );
      return;
    }
    await context.read<CompanyCubit>().fetchCompanies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.White,
      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<CompanyCubit, CompanyState>(
              listener: (context, state) {
                if (state is CompanyFailure) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message)),
                  );
                }
              },
              builder: (context, state) {
                if (state is CompanyLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CompanySuccess) {
                  final list = state.companies;
                  if (list.isEmpty) {
                    return const Center(child: Text('لا توجد شركات متاحة.'));
                  }
                  return RefreshIndicator(
                    onRefresh: _onRefresh,
                    child: ListView.builder(
                      physics: const AlwaysScrollableScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemCount: list.length,
                      itemBuilder: (_, i) {
                        final c = list[i];
                        // تصحيح مسار الشعار ليشمل الـ baseUrl
                        final rawLogo = c.logo;
                        final logoUrl = rawLogo.startsWith('http')
                            ? rawLogo
                            : '${EndPoint.baseUrl}$rawLogo';

                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          child: InkWell(
                            onTap: () {
                              CacheHelper().saveData(
                                key: ApiKey.xSchema,
                                value: c.schemaName,
                              );

                              customNavigat(context, '/invoices', extra: {
                                'companyName': c.companyName,
                                'companyImag': logoUrl,
                              });
                              // GoRouter.of(context).push('/invoices');
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(14),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ListTile(
                                contentPadding: const EdgeInsets.all(12),
                                leading: CircleAvatar(
                                  radius: 28,
                                  backgroundColor: Colors.grey.shade200,
                                  backgroundImage: NetworkImage(logoUrl),
                                ),
                                title: Text(
                                  c.companyName,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  c.active == 'false'
                                      ? AppStrings.active
                                      : AppStrings.inactive,
                                  style: TextStyle(
                                    color: c.active == 'false'
                                        ? Colors.green
                                        : Colors.red,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                trailing: Icon(
                                  c.active == 'false'
                                      ? Icons.check_circle
                                      : Icons.cancel,
                                  color: c.active == 'false'
                                      ? Colors.green
                                      : Colors.red,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }

                // في حالة الخطأ والـ cache خالٍ
                if (state is CompanyFailure) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.wifi_off,
                            size: 64, color: Colors.grey),
                        const SizedBox(height: 16),
                        Text(state.message, textAlign: TextAlign.center),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _onRefresh,
                          child: const Text('إعادة المحاولة'),
                        ),
                      ],
                    ),
                  );
                }

                return const SizedBox.shrink();
              },
            ),
          ),

          // شريط التنقل السفلي
          // NavigationBarItems(
          //   selectedIndex: 1,
          //   showBarcode: true,
          // ),
        ],
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
