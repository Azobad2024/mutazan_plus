import 'package:flutter/material.dart';
import 'package:mutazan_plus/core/utils/app_text_styles.dart';

class WelcomeTextWidget extends StatelessWidget {
  const WelcomeTextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Align(
      child: Text(
        text,
        style: CustomTextStyles.poppins600style28.copyWith(
          color: isDark ? Colors.white : theme.textTheme.headlineSmall?.color,
        ),
      ),
    );
  }
}
