// lib/features/auth/presentation/widgets/sign_in/biometric_login_button.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/core/functions/navigation.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/core/widgets/show_top_snack_bar.dart';
import 'package:mutazan_plus/features/auth/biometric/BiometricAuthPresenter.dart';
import 'package:mutazan_plus/features/auth/biometric/BiometricAuthService.dart';

class BiometricLoginButton extends StatefulWidget {
  const BiometricLoginButton({super.key});

  @override
  State<BiometricLoginButton> createState() => _BiometricLoginButtonState();
}

class _BiometricLoginButtonState extends State<BiometricLoginButton> {
  final _presenter = BiometricAuthPresenter(BiometricAuthService());
  bool _available = false;

  @override
  void initState() {
    super.initState();
    _checkAvailability();
  }

  Future<void> _checkAvailability() async {
    // تأكد أولاً من وجود بيانات مصادقة محفوظة
    final hasToken = CacheHelper().getData(key: ApiKey.access) != null;
    if (!hasToken) {
      setState(() => _available = false);
      return;
    }
    // تأكد ثانياً من توفر مجسّات البصمة على الجهاز
    final biometrics = await _presenter.getAvailableBiometrics();
    setState(() => _available = biometrics.isNotEmpty);
  }

  Future<void> _onPressed() async {
    // إذا حُذفت بيانات الدخول من الكاش بين المحاولات
    final token = CacheHelper().getData(key: ApiKey.access);
    if (token == null) {
      showTopSnackBar(
        context,
        message: AppStrings.loginFirst.tr,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      );

      return;
    }

    final success = await _presenter.authenticate();
    if (success) {
      // التنقل للصفحة الرئيسية مع الاحتفاظ بسجلّ الدخول
      customReplacementNavigate(context, '/homeView');
    } else {
      showTopSnackBar(
        context,
        message: AppStrings.biometricAuthFailed.tr,
        backgroundColor: Theme.of(context).colorScheme.secondary,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_available) {
      // لا تعرض الزر إن لم تتوفر البيانات أو البصمة
      return const SizedBox.shrink();
    }
    return Center(
      child: TextButton.icon(
        onPressed: _onPressed,
        icon: const Icon(Icons.fingerprint),
        label: Text(
          'useFingerprint'.tr,
          style: TextStyle(color: Colors.lightBlue),
        ),
        style: TextButton.styleFrom(
          foregroundColor: Colors.lightBlue,
        ),
      ),
    );
  }
}

// // biometric_login_button.dart

// import 'package:flutter/material.dart';
// import 'package:mutazan_plus/core/functions/navigation.dart';
// import 'package:mutazan_plus/features/auth/biometric/BiometricAuthService.dart';
// import 'package:mutazan_plus/features/auth/biometric/BiometricAuthPresenter.dart';
// import 'package:get/get.dart'; // إذا كنت تستخدم الترجمة مع GetX

// class BiometricLoginButton extends StatelessWidget {
//   BiometricLoginButton({Key? key}) : super(key: key);

//   final BiometricAuthPresenter _biometricAuthPresenter =
//       BiometricAuthPresenter(BiometricAuthService());

//   Future<void> _authenticateWithBiometrics(BuildContext context) async {
//     bool isAuthenticated = await _biometricAuthPresenter.authenticate();
//     if (isAuthenticated) {
//       customReplacementNavigate(
//         context, '/home'
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('biometricAuthFailed'.tr)),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: TextButton.icon(
//         onPressed: () => _authenticateWithBiometrics(context),
//         icon: const Icon(Icons.fingerprint),
//         label: Text('useFingerprint'.tr),
//       ),
//     );
//   }
// }
