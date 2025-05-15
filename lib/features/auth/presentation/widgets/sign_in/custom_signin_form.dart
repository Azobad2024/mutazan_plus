// lib/features/auth/presentation/widgets/sign_in/custom_signin_form.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_cubit.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_state.dart';
import 'package:mutazan_plus/features/auth/presentation/widgets/sign_in/biometric_login_button.dart';
import 'package:mutazan_plus/features/auth/presentation/widgets/sign_in/user_name_input_field.dart';
import 'password_input_field.dart';
import 'sign_in_button.dart';

class CustomSignInForm extends StatelessWidget {
  const CustomSignInForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final cubit = context.read<UserCubit>();
        return Form(
          key: cubit.signInFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const UserNameInputField(),
              const SizedBox(height: 30),
              const PasswordInputField(),
              const SizedBox(height: 16),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgot Password?",
                    style: TextStyle(color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SignInButton(state: state),
              const SizedBox(height: 16),
              BiometricLoginButton(),
            ],
          ),
        );
      },
    );
  }
}
