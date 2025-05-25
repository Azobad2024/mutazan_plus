import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;
import 'package:mutazan_plus/core/utils/app_strings.dart';

class InvoicesAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isSearching;
  final TextEditingController searchController;
  final FocusNode searchFocus;
  final VoidCallback onSearchStart;

  const InvoicesAppBar({
    super.key,
    required this.isSearching,
    required this.searchController,
    required this.searchFocus,
    required this.onSearchStart,
  });

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppBar(
      backgroundColor: AppColors.backgroundColor,
      elevation: 0,
      title: isSearching
          ? _buildSearchField(context, theme)
          : Text(
              AppStrings.invoices.tr,
              style: theme.textTheme.headlineSmall!
                  .copyWith(color: theme.colorScheme.onPrimary),
            ),
      actions: [
        if (!isSearching)
          IconButton(
            icon: Icon(Icons.search, color: theme.colorScheme.onPrimary),
            onPressed: onSearchStart,
          ),
        SizedBox(
          width: responsive.ResponsiveValue<double>(
            context,
            defaultValue: 8,
            conditionalValues: [
              responsive.Condition.largerThan(name: responsive.TABLET, value: 16),
            ],
          ).value,
        ),
      ],
    );
  }

  Widget _buildSearchField(BuildContext context, ThemeData theme) {
    final radius = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 12,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.TABLET, value: 16),
      ],
    ).value;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: responsive.ResponsiveValue<double>(
          context,
          defaultValue: 8,
          conditionalValues: [
            responsive.Condition.largerThan(name: responsive.TABLET, value: 16),
          ],
        ).value,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: responsive.ResponsiveValue<double>(
          context,
          defaultValue: 12,
          conditionalValues: [
            responsive.Condition.largerThan(name: responsive.TABLET, value: 20),
          ],
        ).value,
      ),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: TextField(
        controller: searchController,
        focusNode: searchFocus,
        textAlignVertical: TextAlignVertical.center,
        style: theme.textTheme.bodyMedium,
        decoration: InputDecoration(
          isDense: true,
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: theme.iconTheme.color),
          hintText: AppStrings.searchHint.tr,
          hintStyle: theme.textTheme.bodyMedium!
              .copyWith(color: theme.hintColor),
        ),
      ),
    );
  }
}
