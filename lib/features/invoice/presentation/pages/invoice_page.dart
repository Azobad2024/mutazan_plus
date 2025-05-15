// lib/features/invoice/presentation/pages/invoices_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:mutazan_plus/core/connection/network_info.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/core/utils/app_assets.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';

import 'package:mutazan_plus/features/invoice/domain/entities/invoice_entity.dart';
import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_state.dart';

import 'package:mutazan_plus/core/widgets/custom_navbar.dart';

class InvoicesPage extends StatefulWidget {
  const InvoicesPage({
    super.key,
    required this.companyName,
    required this.companyImag,
  });
  final String companyName;
  final String companyImag;

  @override
  State<InvoicesPage> createState() => _InvoicesPageState();
}

class _InvoicesPageState extends State<InvoicesPage> {
  late final InvoiceCubit _cubit;
  late final TextEditingController _searchController;
  late final FocusNode _searchFocus;
  bool _isSearching = false;

  List<InvoiceEntity> _all = [];
  List<InvoiceEntity> _filtered = [];
  final Set<int> _verifiedIds = {};
  final Map<int, int> _reportedViolations = {};

  final List<Map<String, dynamic>> _violations = [
    {'id': 1, 'name': 'عكس مسار'},
    {'id': 2, 'name': 'خروج بغير لوحة'},
    {'id': 3, 'name': 'عدم وجود بطاقة وزن أولى'},
    {'id': 4, 'name': 'تجاوز الوزن القانوني'},
    {'id': 5, 'name': 'بيانات غير مكتملة'},
    {'id': 6, 'name': 'فاتورة غير صحيحة'},
  ];

  @override
  void initState() {
    super.initState();
    final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
    _cubit = getIt<InvoiceCubit>()..fetchInvoices(xSchema);

    _searchController = TextEditingController()..addListener(_onSearchChanged);
    _searchFocus = FocusNode();
  }

  @override
  void dispose() {
    _searchController
      ..removeListener(_onSearchChanged)
      ..dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    final q = _searchController.text.trim().toLowerCase();
    setState(() {
      _filtered = q.isEmpty
          ? List.from(_all)
          : _all.where((inv) {
              final mat = inv.material.toString().toLowerCase();
              final id = inv.id.toString();
              return mat.contains(q) || id.contains(q);
            }).toList();
    });
  }

  Future<void> _onRefresh() async {
    final networkInfo = getIt<NetworkInfo>();
    if (!await networkInfo.isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يوجد اتصال بالإنترنت')),
      );
      return;
    }
    final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
    await _cubit.fetchInvoices(xSchema);
  }

  // =====================================================
  // عرض خيارات التحقق أو الإبلاغ
  void _showOptionsDialog(InvoiceEntity inv) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppStrings.invoiceOptions.tr),
        content: Text(AppStrings.chooseOption.tr),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _verifyInvoice(inv.id);
            },
            child: Text(AppStrings.confirmInvoice.tr),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showReportDialog(inv.id);
            },
            child: Text(AppStrings.reportViolation.tr),
          ),
        ],
      ),
    );
  }

  void _verifyInvoice(int id) async {
    final res = await _cubit.verify(id);
    res.fold(
      (f) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(f.errMessage))),
      (_) => setState(() {
        _verifiedIds.add(id);
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppStrings.invoiceVerified.tr)));
      }),
    );
  }

  void _showReportDialog(int id) {
    showDialog<int>(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text(AppStrings.selectViolationType.tr),
        children: _violations.map((v) {
          return SimpleDialogOption(
            child: Text(v['name'] as String),
            onPressed: () => Navigator.pop(context, v['id'] as int),
          );
        }).toList(),
      ),
    ).then((violationId) {
      if (violationId != null) {
        _reportInvoice(id, violationId);
      }
    });
  }

  void _reportInvoice(int id, int violationId) async {
    final res = await _cubit.report(id, violationId);
    res.fold(
      (f) => ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(f.errMessage))),
      (_) => setState(() {
        _reportedViolations[id] = violationId;
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(AppStrings.violationReported.tr)));
      }),
    );
  }

  // =====================================================
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NavCubit>(
      create: (_) => NavCubit(), // NavCubit المسؤول عن تحديث selectedIndex
      child: BlocConsumer<InvoiceCubit, InvoiceState>(
        bloc: _cubit,
        listener: (ctx, state) {
          if (state is InvoiceSuccess) {
            _all = state.invoices;
            _filtered = List.from(_all);
          }
          if (state is InvoiceFailure) {
            ScaffoldMessenger.of(ctx)
                .showSnackBar(SnackBar(content: Text(state.message)));
          }
        },
        builder: (ctx, state) {
          return GestureDetector(
            onTap: () {
              if (_isSearching) {
                _searchFocus.unfocus();
                setState(() => _isSearching = false);
              }
            },
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              backgroundColor: AppColors.backgroundColor,
              appBar: AppBar(
                backgroundColor: AppColors.backgroundColor,
                elevation: 0,
                title: Text(widget.companyName,
                    style: const TextStyle(color: Colors.white)),
                actions: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isSearching
                        ? _buildSearchField()
                        : _buildSearchButton(),
                  ),
                  const SizedBox(width: 12),
                ],
              ),
              body: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(30)),
                ),
                child: Column(
                  children: [
                    _buildHeader(),
                    Expanded(child: _buildBody(state)),
                  ],
                ),
              ),
              bottomNavigationBar: BlocBuilder<NavCubit, int>(
                builder: (context, selectedIndex) {
                  return Container(
                    color: AppColors.White,
                    child: NavigationBarItems(
                      // selectedIndex: selectedIndex,
                      showBarcode: true,
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }

  // =====================================================
  Widget _buildSearchButton() => InkWell(
        onTap: () {
          setState(() => _isSearching = true);
          Future.delayed(const Duration(milliseconds: 100), () {
            FocusScope.of(context).requestFocus(_searchFocus);
          });
        },
        child: Row(
          children: const [
            Text('بحث', style: TextStyle(color: Colors.white)),
            SizedBox(width: 5),
            Icon(Icons.search, color: Colors.white),
          ],
        ),
      );

  Widget _buildSearchField() => Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(20)),
        child: TextField(
          controller: _searchController,
          focusNode: _searchFocus,
          decoration: InputDecoration(
            hintText: AppStrings.searchHint.tr,
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(horizontal: 12),
          ),
        ),
      );

  // =====================================================
  Widget _buildHeader() {
    final count = _filtered.length;
    // استخدم الصورة الممرّرة مباشرة من الــ widget
    final imageProvider = widget.companyImag.isNotEmpty
        ? NetworkImage(widget.companyImag)
        : const AssetImage(Assets.imagesAvatar) as ImageProvider;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: const [
          BoxShadow(color: Colors.black26, blurRadius: 5, offset: Offset(0, 2))
        ],
      ),
      child: Row(
        children: [
          _statColumn(AppStrings.numberOfInvoices.tr, count.toString()),
          const Spacer(),
          CircleAvatar(radius: 30, backgroundImage: imageProvider),
        ],
      ),
    );
  }

  Widget _statColumn(String label, String value) => Column(
        children: [
          Text(label, style: const TextStyle(fontSize: 16)),
          const SizedBox(height: 4),
          Text(value,
              style:
                  const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      );

  // =====================================================
  Widget _buildBody(InvoiceState state) {
    if (state is InvoiceLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is InvoiceFailure) {
      return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error, size: 64, color: Colors.red[300]),
            const SizedBox(height: 16),
            Text(state.message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: _onRefresh, child: const Text('إعادة المحاولة')),
          ],
        ),
      );
    }
    // success
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        itemCount: _filtered.length,
        itemBuilder: (_, i) {
          final inv = _filtered[i];
          final isVerified = _verifiedIds.contains(inv.id);
          final reportedType = _reportedViolations[inv.id];
          return InvoiceCard(
            invoiceNumber: inv.id.toString(),
            date: inv.datetime.toString(),
            quantity: inv.quantity,
            material: inv.material.toString(),
            netWeight: inv.netWeight,
            isVerified: isVerified,
            reportedViolation: reportedType,
            onTap: () => _showOptionsDialog(inv),
          );
        },
      ),
    );
  }
}

// ---------------------------------------------------

class InvoiceCard extends StatelessWidget {
  final String invoiceNumber, date, quantity, material, netWeight;
  final bool isVerified;
  final int? reportedViolation;
  final VoidCallback onTap;

  const InvoiceCard({
    super.key,
    required this.invoiceNumber,
    required this.date,
    required this.quantity,
    required this.material,
    required this.netWeight,
    required this.isVerified,
    this.reportedViolation,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color borderColor = Colors.blueGrey;
    Widget statusWidget = const SizedBox.shrink();

    if (isVerified) {
      borderColor = Colors.green;
      statusWidget = const Icon(Icons.verified, color: Colors.green, size: 28);
    } else if (reportedViolation != null) {
      borderColor = Colors.red;
      statusWidget = const Icon(Icons.report, color: Colors.red, size: 28);
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: borderColor, width: 2),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4))
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child:
                      Icon(Icons.menu_book, color: Colors.blueGrey, size: 28),
                ),
                Expanded(child: Container(height: 1, color: Colors.blueGrey)),
                statusWidget,
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: InvoiceLabel(
                        title: AppStrings.invoiceNumber.tr,
                        value: invoiceNumber)),
                const SizedBox(width: 8),
                Expanded(
                    child: InvoiceLabel(
                        title: AppStrings.quantity.tr, value: quantity)),
                const SizedBox(width: 8),
                Expanded(
                    child: InvoiceLabel(
                        title: AppStrings.date.tr, value: date, isDate: true)),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                    child: InvoiceLabel(
                        title: AppStrings.netWeight.tr, value: netWeight)),
                const SizedBox(width: 8),
                Expanded(
                    child: InvoiceLabel(
                        title: AppStrings.material.tr, value: material)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class InvoiceLabel extends StatelessWidget {
  final String title, value;
  final bool isDate;
  const InvoiceLabel({
    super.key,
    required this.title,
    required this.value,
    this.isDate = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: isDate ? Colors.blue : Colors.black),
          ),
        ],
      ),
    );
  }
}

// // lib/features/invoice/presentation/pages/invoices_page.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mutazan_plus/core/databases/api/end_points.dart';
// import 'package:mutazan_plus/core/services/services_locator.dart';
// import 'package:mutazan_plus/core/utils/app_strings.dart';
// import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
// import '../cubit/invoice_cubit.dart';
// import '../cubit/invoice_state.dart';

// class InvoicesPage extends StatelessWidget {
//   const InvoicesPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // اقرأ x-schema من الكاش
//     final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
//     return BlocProvider<InvoiceCubit>(
//       create: (_) => getIt<InvoiceCubit>()..fetchInvoices(xSchema),
//       child: Scaffold(
//         appBar: AppBar(title: const Text(AppStrings.invoices)),
//         body: BlocBuilder<InvoiceCubit, InvoiceState>(
//           builder: (context, state) {
//             if (state is InvoiceLoading) {
//               return const Center(child: CircularProgressIndicator());
//             }
//             if (state is InvoiceFailure) {
//               return Center(child: Text(state.message));
//             }
//             if (state is InvoiceSuccess) {
//               final invoices = state.invoices;
//               return ListView.builder(
//                 itemCount: invoices.length,
//                 itemBuilder: (_, i) {
//                   final inv = invoices[i];
//                   return ListTile(
//                     title: Text('${AppStrings.invoice} #${inv.id}'),
//                     subtitle: Text(
//                       '${AppStrings.quantity}: ${inv.quantity}\n'
//                       '${AppStrings.netWeight}: ${inv.netWeight}\n'
//                       '${AppStrings.datetime}: ${inv.datetime}',
//                     ),
//                   );
//                 },
//               );
//             }
//             return const SizedBox.shrink();
//           },
//         ),
//       ),
//     );
//   }
// }
