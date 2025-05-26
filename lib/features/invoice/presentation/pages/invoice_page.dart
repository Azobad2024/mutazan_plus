// lib/features/invoice/presentation/pages/invoices_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
import 'package:mutazan_plus/core/widgets/show_top_snack_bar.dart';
import 'package:mutazan_plus/features/invoice/domain/entities/invoice_entity.dart';
import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_state.dart';
import 'package:mutazan_plus/features/invoice/presentation/widgets/invoice_card.dart';
import 'package:mutazan_plus/features/invoice/presentation/widgets/verify_invoice_dialog.dart';
import 'package:mutazan_plus/core/connection/network_info.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';
import 'package:responsive_framework/responsive_framework.dart'
    as responsive_framework;
import '../widgets/invoices_app_bar.dart';
import '../widgets/invoices_header.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;

class InvoicesPage extends StatefulWidget {
  final String companyName;
  final String companyImag;

  const InvoicesPage({
    super.key,
    required this.companyName,
    required this.companyImag,
  });

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  late final InvoiceCubit _cubit;
  late final TextEditingController _searchController;
  late final FocusNode _searchFocus;
  late bool _showPending;

  bool _isSearching = false;
  List<InvoiceEntity> _all = [];
  List<InvoiceEntity> _filtered = [];
  final Set<int> _verifiedIds = {};

  @override
  void initState() {
    super.initState();
    final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
    _cubit = getIt<InvoiceCubit>()..fetchInvoices(xSchema);
    _searchController = TextEditingController()..addListener(_onSearchChanged);
    _searchFocus = FocusNode();
    // قيمة افتراضية حتى نقراها في didChangeDependencies
    _showPending = false;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // استخرج showPending من arguments
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    _showPending = args?['showPending'] as bool? ?? false;
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _applyFilter() {
    // يطبق الفلترة بناءً على _showPending ثم البحث
    final base = _showPending
        ? _all.where((inv) => !inv.isVerified).toList()
        : List<InvoiceEntity>.from(_all);
    final q = _searchController.text.trim().toLowerCase();
    if (q.isEmpty) {
      _filtered = base;
    } else {
      _filtered = base.where((inv) {
        return inv.id.toString().contains(q) ||
            inv.materialName.toLowerCase().contains(q) ||
            inv.quantity.toLowerCase().contains(q);
      }).toList();
    }
  }

  void _onSearchChanged() {
    setState(_applyFilter);
  }

  Future<void> _onRefresh() async {
    if (!await getIt<NetworkInfo>().isConnected) {
      showTopSnackBar(context, message: AppStrings.noInternet.tr);
      return;
    }
    final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
    await _cubit.fetchInvoices(xSchema);
    // بعد التحميل نطبّق الفلترة من جديد
    setState(_applyFilter);
  }

  void _showVerifyDialog(InvoiceEntity inv) {
    showVerifyInvoiceDialog(
      context: context,
      invoice: inv,
      alreadyVerified: _verifiedIds.contains(inv.id),
      onConfirm: _verifyInvoice,
    );
  }

  Future<void> _verifyInvoice(int id) async {
    final res = await _cubit.verify(id);
    res.fold(
      (f) => showTopSnackBar(context,
          message: f.errMessage, backgroundColor: Colors.red),
      (_) {
        setState(() {
          _verifiedIds.add(id);
          _applyFilter(); // بعد التأكيد نعيد تطبيق الفلترة
        });
        showTopSnackBar(context,
            message: AppStrings.invoiceVerified.tr,
            backgroundColor: Colors.green);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return BlocConsumer<InvoiceCubit, InvoiceState>(
      bloc: _cubit,
      listener: (ctx, state) {
        if (state is InvoiceSuccess) {
          _all = state.invoices;
          setState(_applyFilter);
        }
        if (state is InvoiceFailure) {
          showTopSnackBar(ctx,
              message: state.message, backgroundColor: theme.colorScheme.error);
        }
      },
      builder: (_, state) {
        return GestureDetector(
          onTap: () {
            if (_isSearching) {
              _searchFocus.unfocus();
              setState(() => _isSearching = false);
            }
          },
          child: Scaffold(
            appBar: InvoicesAppBar(
              title: widget.companyName,
              isSearching: _isSearching,
              searchController: _searchController,
              searchFocus: _searchFocus,
              onSearchStart: () => setState(() => _isSearching = true),
            ),
            body: Column(
              children: [
                InvoicesHeader(count: _filtered.length),
                Expanded(child: _buildBody(state)),
              ],
            ),
            bottomNavigationBar: BlocBuilder<NavCubit, int>(builder: (_, __) {
              return NavigationBarItems(showBarcode: false);
            }),
          ),
        );
      },
    );
  }

  Widget _buildBody(InvoiceState state) {
    if (state is InvoiceLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_filtered.isEmpty) {
      return Center(
        child: Text(AppStrings.noInvoices.tr,
            style: Theme.of(context).textTheme.bodyMedium),
      );
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      backgroundColor: AppColors.container1Color,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(
          vertical: responsive_framework.ResponsiveValue<double>(context,
              defaultValue: 16,
              conditionalValues: [
                responsive_framework.Condition.largerThan(
                    name: responsive_framework.MOBILE, value: 24)
              ]).value!,
        ),
        itemCount: _filtered.length,
        itemBuilder: (_, i) {
          final inv = _filtered[i];
          return 
          InvoiceCard(
            invoiceNumber: inv.id.toString(),
            date: inv.datetime.toString(),
            quantity: inv.quantity,
            material: inv.materialName,
            netWeight: inv.netWeight,
            isVerified: _verifiedIds.contains(inv.id),
            onTap: () => _showVerifyDialog(inv),
          );
        },
      ),
    );
  }
}













// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';
// import 'package:mutazan_plus/core/utils/app_colors.dart';
// import 'package:responsive_framework/responsive_framework.dart' as responsive_framework;

// import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
// import 'package:mutazan_plus/core/widgets/show_top_snack_bar.dart';
// import 'package:mutazan_plus/features/invoice/domain/entities/invoice_entity.dart';
// import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_cubit.dart';
// import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_state.dart';
// import 'package:mutazan_plus/features/invoice/presentation/widgets/invoice_card.dart';
// import 'package:mutazan_plus/features/invoice/presentation/widgets/verify_invoice_dialog.dart';
// import 'package:mutazan_plus/core/connection/network_info.dart';
// import 'package:mutazan_plus/core/databases/api/end_points.dart';
// import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
// import 'package:mutazan_plus/core/services/services_locator.dart';
// import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';
// import '../widgets/invoices_app_bar.dart';
// import '../widgets/invoices_header.dart';
// import 'package:mutazan_plus/core/utils/app_strings.dart';

// class InvoicesPage extends StatefulWidget {
//   final String companyName;
//   final String companyImag;

//   const InvoicesPage({
//     super.key,
//     required this.companyName,
//     required this.companyImag,
//   });

//   @override
//   State<InvoicesPage> createState() => _InvoicesPageState();
// }

// class _InvoicesPageState extends State<InvoicesPage> {
//   late final InvoiceCubit _cubit;
//   late final TextEditingController _searchController;
//   late final FocusNode _searchFocus;
//   bool _isSearching = false;
//   List<InvoiceEntity> _all = [];
//   List<InvoiceEntity> _filtered = [];
//   final Set<int> _verifiedIds = {};

//   @override
//   void initState() {
//     super.initState();
//     final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
//     _cubit = getIt<InvoiceCubit>()..fetchInvoices(xSchema);
//     _searchController = TextEditingController()..addListener(_onSearchChanged);
//     _searchFocus = FocusNode();
//   }

//   @override
//   void dispose() {
//     _searchController
//       ..removeListener(_onSearchChanged)
//       ..dispose();
//     _searchFocus.dispose();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     final q = _searchController.text.trim().toLowerCase();
//     setState(() {
//       _filtered = q.isEmpty
//         ? List.from(_all)
//         : _all.where((inv) {
//             return inv.id.toString().contains(q)
//                 || inv.materialName.toLowerCase().contains(q)
//                 || inv.quantity.toLowerCase().contains(q);
//           }).toList();
//     });
//   }

//   Future<void> _onRefresh() async {
//     if (!await getIt<NetworkInfo>().isConnected) {
//       showTopSnackBar(context, message: AppStrings.noInternet.tr);
//       return;
//     }
//     final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
//     await _cubit.fetchInvoices(xSchema);
//   }

//   void _showVerifyDialog(InvoiceEntity inv) {
//     showVerifyInvoiceDialog(
//       context: context,
//       invoice: inv,
//       alreadyVerified: _verifiedIds.contains(inv.id),
//       onConfirm: _verifyInvoice,
//     );
//   }

//   Future<void> _verifyInvoice(int id) async {
//     final res = await _cubit.verify(id);
//     res.fold(
//       (f) => showTopSnackBar(
//         context,
//         message: f.errMessage,
//         backgroundColor: Theme.of(context).colorScheme.error,
//       ),
//       (_) {
//         setState(() => _verifiedIds.add(id));
//         showTopSnackBar(
//           context,
//           message: AppStrings.invoiceVerified.tr,
//           backgroundColor: Theme.of(context).colorScheme.secondary,
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);

//     return BlocConsumer<InvoiceCubit, InvoiceState>(
//       bloc: _cubit,
//       listener: (ctx, state) {
//         if (state is InvoiceSuccess) {
//           _all = state.invoices;
//           _filtered = List.from(_all);
//         }
//         if (state is InvoiceFailure) {
//           showTopSnackBar(ctx, message: state.message, backgroundColor: theme.colorScheme.error);
//         }
//       },
//       builder: (ctx, state) {
//         return GestureDetector(
//           onTap: () {
//             if (_isSearching) {
//               _searchFocus.unfocus();
//               setState(() => _isSearching = false);
//             }
//           },
//           child: Scaffold(
//             appBar: InvoicesAppBar(
//               isSearching: _isSearching,
//               searchController: _searchController,
//               searchFocus: _searchFocus,
//               onSearchStart: () => setState(() => _isSearching = true),
//             ),
//             body: Column(
//               children: [
//                 InvoicesHeader(count: _filtered.length),
//                 Expanded(child: _buildBody(state)),
//               ],
//             ),
//             bottomNavigationBar: BlocBuilder<NavCubit, int>(
//               builder: (_, __) => NavigationBarItems(showBarcode: false),
//             ),
//           ),
//         );
//       },
//     );
//   }

//   Widget _buildBody(InvoiceState state) {
//     if (state is InvoiceLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     if (_filtered.isEmpty) {
//       return Center(child: Text(AppStrings.noInvoices.tr, style: Theme.of(context).textTheme.bodyMedium));
//     }
//     return RefreshIndicator(
//       onRefresh: _onRefresh,
//       backgroundColor: AppColors.primaryBackground,
//       child: ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         padding: EdgeInsets.symmetric(
//           vertical: responsive_framework.ResponsiveValue<double>(context, defaultValue: 16, conditionalValues: [
//             responsive_framework.Condition.largerThan(name: responsive_framework.MOBILE, value: 24)
//           ]).value,
//         ),
//         itemCount: _filtered.length,
//         itemBuilder: (ctx, i) {
//           final inv = _filtered[i];
//           return InvoiceCard(
//             invoiceNumber: inv.id.toString(),
//             date: inv.datetime.toString(),
//             quantity: inv.quantity,
//             material: inv.materialName,
//             netWeight: inv.netWeight,
//             isVerified: _verifiedIds.contains(inv.id),
//             onTap: () => _showVerifyDialog(inv),
//           );
//         },
//       ),
//     );
//   }
// }







// // lib/features/invoice/presentation/pages/invoices_page.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
// import 'package:mutazan_plus/core/widgets/show_top_snack_bar.dart';
// import 'package:mutazan_plus/features/invoice/domain/entities/invoice_entity.dart';
// import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_cubit.dart';
// import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_state.dart';
// import 'package:mutazan_plus/features/invoice/presentation/widgets/invoice_card.dart';
// import '../../../../core/connection/network_info.dart';
// import '../../../../core/databases/api/end_points.dart';
// import '../../../../core/databases/cache/cache_helper.dart';
// import '../../../../core/services/services_locator.dart';
// import '../../../../features/home/presentation/cubit/home_cubit.dart';
// import '../widgets/invoices_app_bar.dart';
// import '../widgets/invoices_header.dart';

// class InvoicesPage extends StatefulWidget {
//   final String companyName;
//   final String companyImag;

//   const InvoicesPage({
//     super.key,
//     required this.companyName,
//     required this.companyImag,
//   });

//   @override
//   State<InvoicesPage> createState() => _InvoicesPageState();
// }

// class _InvoicesPageState extends State<InvoicesPage> {
//   // ---- 1. المتغيرات والتحكم بالبحث ----
//   late final InvoiceCubit _cubit;
//   late final TextEditingController _searchController;
//   late final FocusNode _searchFocus;
//   bool _isSearching = false;
//   List<InvoiceEntity> _all = [];
//   List<InvoiceEntity> _filtered = [];
//   final Set<int> _verifiedIds = {};

//   @override
//   void initState() {
//     super.initState();
//     final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
//     _cubit = getIt<InvoiceCubit>()..fetchInvoices(xSchema);
//     _searchController = TextEditingController()..addListener(_onSearchChanged);
//     _searchFocus = FocusNode();
//   }

//   @override
//   void dispose() {
//     _searchController
//       ..removeListener(_onSearchChanged)
//       ..dispose();
//     _searchFocus.dispose();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     final q = _searchController.text.trim().toLowerCase();
//     setState(() {
//       _filtered = q.isEmpty
//           ? List.from(_all)
//           : _all
//               .where((inv) =>
//                   inv.invoiceMaterials.toString().toLowerCase().contains(q) ||
//                   inv.id.toString().contains(q))
//               .toList();
//     });
//   }

//   Future<void> _onRefresh() async {
//     final net = getIt<NetworkInfo>();
//     if (!await net.isConnected) {
//       showTopSnackBar(context, message: 'لا يوجد اتصال بالإنترنت');
//       return;
//     }
//     final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
//     await _cubit.fetchInvoices(xSchema);
//   }

//   void _showVerifyDialog(InvoiceEntity inv) {
//     // كما في الكود الأصلي - يمكن نقله لاحقًا لويدجت أو helper
//   }

//   void _verifyInvoice(int id) async {
//     final res = await _cubit.verify(id);
//     res.fold(
//       (f) => ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(f.errMessage))),
//       (_) => setState(() {
//         _verifiedIds.add(id);
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('تم تأكيد الفاتورة')),
//         );
//       }),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;

//     return BlocProvider<NavCubit>(
//       create: (_) => NavCubit(),
//       child: BlocConsumer<InvoiceCubit, InvoiceState>(
//         bloc: _cubit,
//         listener: (ctx, state) {
//           if (state is InvoiceSuccess) {
//             _all = state.invoices;
//             _filtered = List.from(_all);
//           }
//           if (state is InvoiceFailure) {
//             ScaffoldMessenger.of(ctx)
//                 .showSnackBar(SnackBar(content: Text(state.message)));
//           }
//         },
//         builder: (ctx, state) {
//           return GestureDetector(
//             onTap: () {
//               if (_isSearching) {
//                 _searchFocus.unfocus();
//                 setState(() => _isSearching = false);
//               }
//             },
//             child: Scaffold(
//               appBar: InvoicesAppBar(
//                 isSearching: _isSearching,
//                 searchController: _searchController,
//                 searchFocus: _searchFocus,
//                 onSearchStart: () => setState(() => _isSearching = true),
//               ),
//               body: Column(
//                 children: [
//                   InvoicesHeader(count: _filtered.length),
//                   Expanded(child: _buildBody(state)),
//                 ],
//               ),
//               bottomNavigationBar: BlocBuilder<NavCubit, int>(
//                 builder: (context, selectedIndex) {
//                   return NavigationBarItems(showBarcode: false);
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildBody(InvoiceState state) {
//     if (state is InvoiceLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     if (_filtered.isEmpty) {
//       return const Center(child: Text('لا توجد فواتير'));
//     }

//     return RefreshIndicator(
//       onRefresh: _onRefresh,
//       child: ListView.builder(
//         itemCount: _filtered.length,
//         itemBuilder: (ctx, i) {
//           final inv = _filtered[i];
//           final isVerified = _verifiedIds.contains(inv.id); // ← صححنا هنا
//           // final isVerified = _verifiedIds.contains(_filtered[0].id);
//           return InvoiceCard(
//             invoiceNumber: inv.id.toString(),
//             date: inv.datetime.toString(),
//             quantity: inv.quantity,
//             material: inv.materialName,
//             netWeight: inv.netWeight,
//             isVerified: isVerified,
//             onTap: () => _showVerifyDialog(inv),
//           );
//         },
//       ),
//     );
//   }
// }
















// // lib/features/invoice/presentation/pages/invoices_page.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mutazan_plus/core/utils/app_assets.dart';
// import 'package:mutazan_plus/core/utils/app_colors.dart';
// import 'package:mutazan_plus/core/utils/app_strings.dart';
// import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
// import 'package:mutazan_plus/core/widgets/show_top_snack_bar.dart';
// import 'package:mutazan_plus/features/invoice/domain/entities/invoice_entity.dart';
// import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_cubit.dart';
// import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_state.dart';
// import 'package:mutazan_plus/features/invoice/presentation/widgets/invoice_card.dart';
// import '../../../../core/connection/network_info.dart';
// import '../../../../core/databases/api/end_points.dart';
// import '../../../../core/databases/cache/cache_helper.dart';
// import '../../../../core/services/services_locator.dart';
// import '../../../../features/home/presentation/cubit/home_cubit.dart';
// import 'package:get/get.dart';

// class InvoicesPage extends StatefulWidget {
//   final String companyName;
//   final String companyImag;

//   const InvoicesPage({
//     super.key,
//     required this.companyName,
//     required this.companyImag,
//   });

//   @override
//   State<InvoicesPage> createState() => _InvoicesPageState();
// }

// class _InvoicesPageState extends State<InvoicesPage> {
//   late final InvoiceCubit _cubit;
//   late final TextEditingController _searchController;
//   late final FocusNode _searchFocus;
//   bool _isSearching = false;

//   List<InvoiceEntity> _all = [];
//   List<InvoiceEntity> _filtered = [];
//   final Set<int> _verifiedIds = {};

//   @override
//   void initState() {
//     super.initState();
//     final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
//     _cubit = getIt<InvoiceCubit>()..fetchInvoices(xSchema);
//     _searchController = TextEditingController()..addListener(_onSearchChanged);
//     _searchFocus = FocusNode();
//   }

//   @override
//   void dispose() {
//     _searchController
//       ..removeListener(_onSearchChanged)
//       ..dispose();
//     _searchFocus.dispose();
//     super.dispose();
//   }

//   void _onSearchChanged() {
//     final q = _searchController.text.trim().toLowerCase();
//     setState(() {
//       _filtered = q.isEmpty
//           ? List.from(_all)
//           : _all.where((inv) {
//               return inv.material.toString().toLowerCase().contains(q) ||
//                   inv.id.toString().contains(q);
//             }).toList();
//     });
//   }

//   Future<void> _onRefresh() async {
//     final net = getIt<NetworkInfo>();
//     if (!await net.isConnected) {
//       showTopSnackBar(
//         context,
//         message: AppStrings.nointernet.tr,
//         backgroundColor: Theme.of(context).colorScheme.secondary,
//       );

//       return;
//     }
//     final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
//     await _cubit.fetchInvoices(xSchema);
//   }

//   void _showVerifyDialog(InvoiceEntity inv) {
//     if (_verifiedIds.contains(inv.id)) {
//       showDialog(
//         context: context,
//         builder: (_) => AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(16),
//           ),
//           title: Text(
//             AppStrings.alreadyVerified.tr,
//             style: Theme.of(context).textTheme.titleLarge,
//           ),
//           content: Text(AppStrings.alreadyBody.tr),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: Text(AppStrings.ok.tr),
//             ),
//           ],
//         ),
//       );
//       return;
//     }

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         title: Row(
//           children: [
//             Icon(Icons.check_circle, color: AppColors.success, size: 28),
//             const SizedBox(width: 8),
//             Expanded(
//               child: Text(
//                 AppStrings.confirmInvoice.tr,
//                 style: Theme.of(context).textTheme.titleLarge,
//               ),
//             ),
//           ],
//         ),
//         content: Text(
//           AppStrings.bodyverifyInvoice.tr,
//           style: Theme.of(context).textTheme.bodyMedium,
//         ),
//         actions: [
//           Center(
//             child: ElevatedButton(
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.success,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8)),
//                 minimumSize: Size(
//                   MediaQuery.of(context).size.width * 0.4,
//                   44,
//                 ),
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//                 _verifyInvoice(inv.id);
//               },
//               child: Text(AppStrings.yesConfirm.tr),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _verifyInvoice(int id) async {
//     final res = await _cubit.verify(id);
//     res.fold(
//       (f) => ScaffoldMessenger.of(context)
//           .showSnackBar(SnackBar(content: Text(f.errMessage))),
//       (_) => setState(() {
//         _verifiedIds.add(id);

//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text(AppStrings.invoiceVerified.tr)),
//         );
//       }),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final isLandscape =
//         MediaQuery.of(context).orientation == Orientation.landscape;
//     final theme = Theme.of(context);
//     return BlocProvider<NavCubit>(
//       create: (_) => NavCubit(),
//       child: BlocConsumer<InvoiceCubit, InvoiceState>(
//         bloc: _cubit,
//         listener: (ctx, state) {
//           if (state is InvoiceSuccess) {
//             _all = state.invoices;
//             _filtered = List.from(_all);
//           }
//           if (state is InvoiceFailure) {
//             ScaffoldMessenger.of(ctx)
//                 .showSnackBar(SnackBar(content: Text(state.message)));
//           }
//         },
//         builder: (ctx, state) {
//           final imageProvider = widget.companyImag.isNotEmpty
//               ? NetworkImage(widget.companyImag)
//               : const AssetImage(Assets.imagesAvatar) as ImageProvider;

//           return GestureDetector(
//             onTap: () {
//               if (_isSearching) {
//                 _searchFocus.unfocus();
//                 setState(() => _isSearching = false);
//               }
//             },
//             child: Scaffold(
//               backgroundColor: theme.colorScheme.background,
//               appBar: AppBar(
//                 backgroundColor: AppColors.backgroundColorAppBar,
//                 elevation: 0,
//                 titleSpacing: 0,
//                 title: Row(
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 12),
//                       child: CircleAvatar(
//                         radius: isLandscape ? 20 : 18,
//                         backgroundImage: imageProvider,
//                       ),
//                     ),
//                     Expanded(
//                       child: Text(
//                         widget.companyName,
//                         style: theme.textTheme.headlineSmall!
//                             .copyWith(color: Colors.white),
//                         overflow: TextOverflow.ellipsis,
//                       ),
//                     ),
//                   ],
//                 ),
//                 actions: [
//                   AnimatedSwitcher(
//                     duration: const Duration(milliseconds: 300),
//                     child: _isSearching
//                         ? _buildSearchField(theme)
//                         : _buildSearchButton(theme),
//                   ),
//                   const SizedBox(width: 12),
//                 ],
//               ),
//               body: SafeArea(
//                 bottom: false,
//                 child: Column(
//                   children: [
//                     _buildHeader(theme, isLandscape),
//                     Expanded(child: _buildBody(state)),
//                   ],
//                 ),
//               ),
//               bottomNavigationBar: BlocBuilder<NavCubit, int>(
//                 builder: (context, selectedIndex) {
//                   return Container(
//                       color: Theme.of(context).canvasColor,
//                       child: NavigationBarItems(showBarcode: false));
//                 },
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }

//   Widget _buildSearchButton(ThemeData theme) => InkWell(
//         onTap: () {
//           setState(() => _isSearching = true);
//           // بعد فتح الحقل نطلب التركيز عليه
//           Future.delayed(const Duration(milliseconds: 100), () {
//             FocusScope.of(context).requestFocus(_searchFocus);
//           });
//         },
//         child: Row(
//           children: [
//             Icon(Icons.search, color: theme.colorScheme.onPrimary),
//             const SizedBox(width: 4),
//             Text(
//               AppStrings.search.tr, // كلمة "بحث"
//               style: theme.textTheme.bodyMedium!
//                   .copyWith(color: theme.colorScheme.onPrimary),
//             ),
//           ],
//         ),
//       );

//   Widget _buildSearchField(ThemeData theme) => Container(
//         margin: const EdgeInsets.symmetric(horizontal: 10),
//         padding: const EdgeInsets.symmetric(horizontal: 8),
//         width: MediaQuery.of(context).size.width * 0.6,
//         decoration: BoxDecoration(
//           color: AppColors.containerColor,
//           borderRadius: BorderRadius.circular(15),
//         ),
//         child: TextField(
//           controller: _searchController,
//           focusNode: _searchFocus,
//           autofocus: true, // يفتح الكيبورد تلقائيًا
//           textAlign: TextAlign.center, // لمحاذاة أفقية
//           textAlignVertical: TextAlignVertical.center, // لمحاذاة عمودية
//           style: theme.textTheme.bodyLarge,
//           decoration: InputDecoration(
//             prefixIcon:
//                 Icon(Icons.search, color: theme.colorScheme.onBackground),
//             hintText: AppStrings.searchHint.tr,
//             hintStyle: theme.textTheme.bodyMedium,
//             border: InputBorder.none,
//             isDense: true,
//           ),
//         ),
//       );

//   Widget _buildHeader(ThemeData theme, bool isLandscape) {
//     final count = _filtered.length;
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.symmetric(
//         vertical: isLandscape ? 12 : 16,
//         horizontal: 16,
//       ),
//       decoration: BoxDecoration(
//         color: AppColors.containerColor,
//         borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
//         boxShadow: const [
//           BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 2))
//         ],
//       ),
//       child: Row(
//         children: [
//           Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 AppStrings.numberOfInvoices.tr,
//                 style: theme.textTheme.bodySmall,
//               ),
//               Text(
//                 '$count',
//                 style: theme.textTheme.headlineMedium!
//                     .copyWith(color: AppColors.primaryColor),
//               ),
//             ],
//           ),
//           const Spacer(),
//           IconButton(
//             icon: Icon(Icons.report, color: AppColors.error, size: 32),
//             onPressed: () {
//               // إضافة مخالفة
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildBody(InvoiceState state) {
//     if (state is InvoiceLoading) {
//       return const Center(child: CircularProgressIndicator());
//     }
//     if (state is InvoiceFailure) {
//       return Center(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Icon(Icons.error, size: 64, color: AppColors.error),
//             const SizedBox(height: 16),
//             Text(state.message, textAlign: TextAlign.center),
//             const SizedBox(height: 16),
//             ElevatedButton(
//               onPressed: _onRefresh,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: AppColors.primaryColor,
//               ),
//               child: Text(AppStrings.retry.tr),
//             ),
//           ],
//         ),
//       );
//     }
//     return RefreshIndicator(
//       backgroundColor: AppColors.primaryBackground,
//       color: AppColors.primaryColor,
//       onRefresh: _onRefresh,
//       child: ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         padding: EdgeInsets.zero,
//         itemCount: _filtered.length,
//         itemBuilder: (_, i) {
//           final inv = _filtered[i];
//           final isVerified = _verifiedIds.contains(inv.id);
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//             child: InvoiceCard(
//               invoiceNumber: inv.id.toString(),
//               date: inv.datetime.toString(),
//               quantity: inv.quantity,
//               material: inv.material.toString(),
//               netWeight: inv.netWeight,
//               isVerified: isVerified,
//               onTap: () => _showVerifyDialog(inv),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
