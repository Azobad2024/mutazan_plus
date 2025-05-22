// lib/features/auth/presentation/widgets/sign_in/sign_in_button.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_cubit.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_state.dart';

class SignInButton extends StatelessWidget {
  final UserState state;
  const SignInButton({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 0.065,
      child: state is SignInLoading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(AppColors.backgroundColor),
              ),
            )
          : ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                textStyle:
                    theme.textTheme.titleMedium!.copyWith(color: Colors.white),
                elevation: 4,
              ),
              onPressed: () {
                // تخبئة لوحة المفاتيح فور الضغط
                FocusScope.of(context).unfocus();

                // ثم تحقق من النموذج
                if (cubit.signInFormKey.currentState!.validate()) {
                  cubit.signIn();
                }
              },
              child: Text(
                AppStrings.signIn.tr,
                style:
                    theme.textTheme.titleMedium!.copyWith(color: Colors.white),
              ),
            ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:mutazan_plus/features/auth/presentation/cubit/user_cubit.dart';
// import 'package:mutazan_plus/features/auth/presentation/cubit/user_state.dart';

// class SignInButton extends StatelessWidget {
//   final UserState state;
//   const SignInButton({super.key, required this.state});

//   @override
//   Widget build(BuildContext context) {
//     final cubit = context.read<UserCubit>();

//     return SizedBox(
//       width: double.infinity,
//       height: 50,
//       child: state is SignInLoading
//           ? const Center(child: CircularProgressIndicator())
//           : ElevatedButton(
//               onPressed: () {
//                 if (cubit.signInFormKey.currentState!.validate()) {
//                   cubit.signIn();
//                 }
//               },
//               child: const Text("Sign In"),
//             ),
//     );
//   }
// }
