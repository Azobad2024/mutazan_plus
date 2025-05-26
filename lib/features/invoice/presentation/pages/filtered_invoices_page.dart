// lib/features/invoice/presentation/pages/filtered_invoices_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/core/widgets/show_top_snack_bar.dart';
import 'package:mutazan_plus/features/invoice/domain/entities/invoice_entity.dart';
import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_cubit.dart';
import 'package:mutazan_plus/features/invoice/presentation/cubit/invoice_state.dart';
import 'package:mutazan_plus/features/invoice/presentation/widgets/invoice_card.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive_framework;
import '../widgets/invoices_app_bar.dart';

class FilteredInvoicesPage extends StatelessWidget {
  final String title;
  final bool showPending;
  const FilteredInvoicesPage({super.key,   required this.title, required this.showPending });

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: InvoicesAppBar(
        title: title,
        isSearching: false,
        searchController: TextEditingController(),
        searchFocus: FocusNode(),
        onSearchStart: () {},
      ),
      body: BlocBuilder<InvoiceCubit, InvoiceState>(
        builder: (context, state) {
          if (state is InvoiceLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is InvoiceFailure) {
            return Center(child: Text(state.message));
          }
          // InvoiceSuccess
          final all = (state as InvoiceSuccess).invoices;
          final filtered = showPending
            ? all.where((inv) => !inv.isVerified).toList()
            : all;
          if (filtered.isEmpty) {
            return Center(child: Text(AppStrings.noInvoices.tr));
          }
          return RefreshIndicator(
            onRefresh: () {
              final schema = CacheHelper().getData(key: ApiKey.xSchema) as String;
              return context.read<InvoiceCubit>().fetchInvoices(schema);
            },
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                vertical: responsive_framework.ResponsiveValue<double>(context,
                  defaultValue: 16,
                  conditionalValues: [
                    responsive_framework.Condition.largerThan(name: responsive_framework.MOBILE, value: 24),
                  ],
                ).value!,
              ),
              itemCount: filtered.length,
              itemBuilder: (_, i) {
                final inv = filtered[i];
                return InvoiceCard(
                  invoiceNumber: inv.id.toString(),
                  date: inv.datetime.toString(),
                  quantity: inv.invoiceMaterials.first.quantity,
                  material: inv.invoiceMaterials.map((m) => m.materialName).join(', '),
                  netWeight: inv.netWeight,
                  isVerified: inv.isVerified,
                  onTap: () {
                    context.read<InvoiceCubit>().verify(inv.id)
                      .then((res) {
                        res.fold(
                          (f) => showTopSnackBar(context, message: f.errMessage, backgroundColor: AppColors.error),
                          (_) => showTopSnackBar(context,
                            message: AppStrings.invoiceVerified.tr,
                            backgroundColor: AppColors.success),
                        );
                      });
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
