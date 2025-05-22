// // lib/features/invoice/presentation/pages/filtered_invoices_page.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:get/get.dart';

// import 'package:mutazan_plus/core/connection/network_info.dart';
// import 'package:mutazan_plus/core/databases/api/end_points.dart';
// import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
// import 'package:mutazan_plus/core/utils/app_assets.dart';
// import 'package:mutazan_plus/core/utils/app_colors.dart';
// import 'package:mutazan_plus/core/utils/app_strings.dart';
// import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
// import 'package:mutazan_plus/core/services/services_locator.dart';

// import 'package:mutazan_plus/features/invoice/domain/entities/invoice_entity.dart';
// import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_cubit.dart';
// import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_state.dart';
// import 'package:mutazan_plus/features/invoice/presentation/pages/invoice_page.dart';

// class FilteredInvoicesPage extends StatefulWidget {
//   final String companyName;
//   final String companyImag;
//   final bool showPending;

//   const FilteredInvoicesPage({
//     Key? key,
//     required this.companyName,
//     required this.companyImag,
//     this.showPending = false,
//   }) : super(key: key);

//   @override
//   State<FilteredInvoicesPage> createState() => _FilteredInvoicesPageState();
// }
// class _FilteredInvoicesPageState extends State<FilteredInvoicesPage> {
//   late final InvoiceCubit _cubit;
//   List<InvoiceEntity> _all = [];
//   List<InvoiceEntity> _filtered = [];

//   @override
//   void initState() {
//     super.initState();
//     final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
//     _cubit = getIt<InvoiceCubit>()..fetchInvoices(xSchema);
//   }

//   Future<void> _onRefresh() async {
//     if (!await getIt<NetworkInfo>().isConnected) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('لا يوجد اتصال بالإنترنت')),
//       );
//       return;
//     }
//     final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
//     await _cubit.fetchInvoices(xSchema);
//   }

//   List<InvoiceEntity> _applyFilter(List<InvoiceEntity> source) {
//     if (widget.showPending) {
//       return source.where((inv) => !inv.isVerified).toList();
//     }
//     return List.of(source);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<InvoiceCubit, InvoiceState>(
//       bloc: _cubit,
//       listener: (ctx, state) {
//         if (state is InvoiceSuccess) {
//           // نغلف التغييرات بـ setState لإعادة بناء الواجهة
//           setState(() {
//             _all = state.invoices;
//             _filtered = _applyFilter(_all);
//           });
//         }
//         if (state is InvoiceFailure) {
//           ScaffoldMessenger.of(ctx).showSnackBar(
//             SnackBar(content: Text(state.message)),
//           );
//         }
//       },
//       builder: (ctx, state) {
//         return Scaffold(
//           backgroundColor: AppColors.backgroundColor,
//           appBar: AppBar(
//             backgroundColor: AppColors.backgroundColor,
//             elevation: 0,
//             title: Text(
//               widget.showPending
//                   ? AppStrings.pendingInvoices.tr
//                   : AppStrings.totalInvoices.tr,
//               style: const TextStyle(color: Colors.white),
//             ),
//           ),
//           body: Container(
//             decoration: BoxDecoration(
//               color: Colors.grey[200],
//               borderRadius:
//                   const BorderRadius.vertical(top: Radius.circular(30)),
//             ),
//             child: Column(
//               children: [
//                 // الهيدر الثابت
//                 Container(
//                   width: double.infinity,
//                   padding: const EdgeInsets.all(16),
//                   decoration: BoxDecoration(
//                     color: Colors.grey[100],
//                     borderRadius:
//                         const BorderRadius.vertical(top: Radius.circular(30)),
//                     boxShadow: const [
//                       BoxShadow(
//                           color: Colors.black26,
//                           blurRadius: 5,
//                           offset: Offset(0, 2))
//                     ],
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Column(
//                         children: [
//                           Text(AppStrings.numberOfInvoices.tr,
//                               style: const TextStyle(fontSize: 16)),
//                           Text('${_filtered.length}',
//                               style: const TextStyle(
//                                   fontSize: 22,
//                                   fontWeight: FontWeight.bold)),
//                         ],
//                       ),
//                       // CircleAvatar(
//                       //   radius: 30,
//                       //   backgroundImage: widget.companyImag.isNotEmpty
//                       //       ? NetworkImage(widget.companyImag)
//                       //       : const AssetImage(Assets.imagesAvatar)
//                       //           as ImageProvider,
//                       // ),
//                     ],
//                   ),
//                 ),

//                 // القائمة مع RefreshIndicator
//                 Expanded(
//                   child: RefreshIndicator(
//                     onRefresh: _onRefresh,
//                     child: Builder(builder: (_) {
//                       if (state is InvoiceLoading) {
//                         return const Center(child: CircularProgressIndicator());
//                       }
//                       if (state is InvoiceFailure) {
//                         return Center(child: Text(state.message));
//                       }
//                       // success أو غيرهما
//                       return ListView.builder(
//                         physics: const AlwaysScrollableScrollPhysics(),
//                         padding: EdgeInsets.zero,
//                         itemCount: _filtered.length,
//                         itemBuilder: (_, i) {
//                           final inv = _filtered[i];
//                           return InvoiceCard(
//                             invoiceNumber: inv.id.toString(),
//                             date: inv.datetime.toString(),
//                             quantity: inv.quantity,
//                             material: inv.material.toString(),
//                             netWeight: inv.netWeight,
//                             isVerified: inv.isVerified,
//                             reportedViolation: null,
//                             onTap: () {
//                               // عند الضغط هنا يمكنك فتح حوار تحقق/مخالفة
//                             },
//                           );
//                         },
//                       );
//                     }),
//                   ),
//                 ),

//                 // شريط التنقل السفلي
//                 const NavigationBarItems(
//                   selectedIndex: 5,
//                   showBarcode: true,
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }






import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/connection/network_info.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/core/utils/app_assets.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';
import 'package:mutazan_plus/features/invoice/domain/entities/invoice_entity.dart';
import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_state.dart';
import 'package:mutazan_plus/features/invoice/presentation/widgets/invoice_card.dart';

enum FilterMode { all, pending }

class FilteredInvoicesPage extends StatefulWidget {
  final String companyName;
  final String companyImag;
  final FilterMode mode;

  const FilteredInvoicesPage({
    super.key,
    required this.companyName,
    required this.companyImag,
    this.mode = FilterMode.all, required showPending,
  });

  @override
  State<FilteredInvoicesPage> createState() => _FilteredInvoicesPageState();
}

class _FilteredInvoicesPageState extends State<FilteredInvoicesPage> {
  late final InvoiceCubit _cubit;
    late final NavCubit _navCubit;
  List<InvoiceEntity> _all = [], _filtered = [];
  final TextEditingController _searchCtrl = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  bool _searching = false;

  final _violations = [
    {'id': 1, 'name': 'فاتورة غير صحيحة'},
  ];

  @override
  void initState() {
    super.initState();
    _navCubit = getIt<NavCubit>();
    _searchCtrl.addListener(_applyFilter);
    final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
    _cubit = getIt<InvoiceCubit>()..fetchInvoices(xSchema);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  void _applyFilter() {
    final q = _searchCtrl.text.trim().toLowerCase();
    var list = List<InvoiceEntity>.from(_all);

    if (widget.mode == FilterMode.pending) {
      list = list.where((inv) => !inv.isVerified).toList();
    }

    if (q.isNotEmpty) {
      list = list.where((inv) {
        return inv.id.toString().contains(q) ||
               inv.material.toString().toLowerCase().contains(q);
      }).toList();
    }

    setState(() => _filtered = list);
  }

  Future<void> _onRefresh() async {
    if (!await getIt<NetworkInfo>().isConnected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('لا يوجد اتصال بالإنترنت')),
      );
      return;
    }
    final xSchema = CacheHelper().getData(key: ApiKey.xSchema) as String;
    await _cubit.fetchInvoices(xSchema);
  }

  void _showOptions(InvoiceEntity inv) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppStrings.invoiceOptions.tr),
        content: Text(AppStrings.chooseOption.tr),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _cubit.verify(inv.id).then((res) {
                res.fold(
                  (f) => ScaffoldMessenger.of(context)
                     .showSnackBar(SnackBar(content: Text(f.errMessage))),
                  (_) {
                    inv.isVerified = true;
                    _applyFilter();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(AppStrings.invoiceVerified.tr)));
                  }
                );
              });
            },
            child: Text(AppStrings.confirmInvoice.tr),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              final pick = await showDialog<int>(
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
              );
              if (pick != null) {
                // _cubit.report(inv.id, pick).then((res) {
                //   res.fold(
                //     (f) => ScaffoldMessenger.of(context)
                //        .showSnackBar(SnackBar(content: Text(f.errMessage))),
                //     (_) {
                //       // علامة مبلّغ عنها لا نستخدمها هنا
                //       ScaffoldMessenger.of(context).showSnackBar(
                //         SnackBar(content: Text(AppStrings.violationReported.tr)));
                //     }
                //   );
                // });
              }
            },
            child: Text(AppStrings.reportViolation.tr),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<InvoiceCubit, InvoiceState>(
      bloc: _cubit,
      listener: (_, state) {
        if (state is InvoiceSuccess) {
          _all = state.invoices;
          _applyFilter();
        }
        if (state is InvoiceFailure) {
          ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (_, state) {
        final title = widget.mode == FilterMode.all
          ? AppStrings.totalInvoices.tr
          : AppStrings.pendingInvoices.tr;

        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.backgroundColor,
            elevation: 0,
            title: Text(title, style: const TextStyle(color: Colors.white)),
            actions: [
              if (_searching)
                SizedBox(
                  width: MediaQuery.of(context).size.width * .6,
                  child: TextField(
                    controller: _searchCtrl,
                    focusNode: _searchFocus,
                    decoration: InputDecoration(
                      hintText: AppStrings.searchHint.tr,
                      border: InputBorder.none,
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    onSubmitted: (_) => setState(() => _searching = false),
                  ),
                )
              else
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    setState(() => _searching = true);
                    Future.delayed(const Duration(milliseconds:100), () {
                      FocusScope.of(context).requestFocus(_searchFocus);
                    });
                  },
                ),
            ],
          ),
          body: Column(children: [
            _buildHeader(),
            Expanded(child: _buildBody(state)),
            // const NavigationBarItems(selectedIndex: 5, showBarcode: true),
          ]),
          bottomNavigationBar: BlocBuilder<NavCubit, int>(
            builder: (context, selectedIndex) {
              return NavigationBarItems(
                // selectedIndex: selectedIndex,
                showBarcode: true,
              );
            },
          ),
        );
      }
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Row(children: [
        Text(AppStrings.numberOfInvoices.tr),
        const SizedBox(width: 8),
        Text(_filtered.length.toString(),
          style: const TextStyle(fontWeight: FontWeight.bold)),
        const Spacer(),
        CircleAvatar(
          radius: 30,
          backgroundImage: widget.companyImag.isNotEmpty
            ? NetworkImage(widget.companyImag)
            : const AssetImage(Assets.imagesAvatar) as ImageProvider,
        ),
      ]),
    );
  }

  Widget _buildBody(InvoiceState state) {
    if (state is InvoiceLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (state is InvoiceFailure) {
      return Center(child: Text(state.message));
    }
    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: _filtered.length,
        itemBuilder: (_, i) {
          final inv = _filtered[i];
          return InvoiceCard(
            invoiceNumber: inv.id.toString(),
            date: inv.datetime.toString(),
            quantity: inv.quantity,
            material: inv.material.toString(),
            netWeight: inv.netWeight,
            isVerified: inv.isVerified,
            // نمرر onTap فقط:
            onTap: () => _showOptions(inv),
          );
        },
      ),
    );
  }
}