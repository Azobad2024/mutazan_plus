import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive_framework;

import 'package:mutazan_plus/features/auth/presentation/cubit/user_cubit.dart';
import 'package:mutazan_plus/features/auth/presentation/widgets/sign_in/biometric_login_button.dart';
import 'package:mutazan_plus/features/auth/presentation/widgets/sign_in/user_name_input_field.dart';
import 'password_input_field.dart';
import 'sign_in_button.dart';

class CustomSignInForm extends StatelessWidget {
  const CustomSignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<UserCubit>().state;
    final cubit = context.read<UserCubit>();

    final fieldSpacing = responsive_framework.ResponsiveValue<double>(
      context,
      defaultValue: 16,
      conditionalValues: [
        responsive_framework.Condition.largerThan(name: responsive_framework.TABLET, value: 24),
      ],
    ).value;

    return Form(
      key: cubit.signInFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const UserNameInputField(),
          SizedBox(height: fieldSpacing),
          const PasswordInputField(),
          SizedBox(height: fieldSpacing * 0.5),
          Align(
  alignment: Alignment.centerRight,
  child: TextButton(
    onPressed: () {},
    child: Builder(
      builder: (context) {
        final theme = Theme.of(context);
        final isDark = theme.brightness == Brightness.dark;
        return Text(
          AppStrings.forgotPassword.tr,
          style: TextStyle(
            color:  Colors.lightBlue ,
            fontSize: responsive_framework.ResponsiveValue<double>(
              context,
              defaultValue: 14,
              conditionalValues: [
                responsive_framework.Condition.largerThan(name: responsive_framework.TABLET, value: 16)
              ],
            ).value,
          ),
        );
      },
    ),
  ),
),

          SizedBox(height: fieldSpacing),
          SignInButton(state: state),
          SizedBox(height: fieldSpacing * 0.5),
          const BiometricLoginButton(),
        ],
      ),
    );
  }
}
