import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_cubit.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_state.dart';

class SignInButton extends StatelessWidget {
  final UserState state;
  const SignInButton({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: state is SignInLoading
          ? const Center(child: CircularProgressIndicator())
          : ElevatedButton(
              onPressed: () {
                if (cubit.signInFormKey.currentState!.validate()) {
                  cubit.signIn();
                }
              },
              child: const Text("Sign In"),
            ),
    );
  }
}
