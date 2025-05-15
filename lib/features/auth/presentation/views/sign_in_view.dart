// lib/features/auth/presentation/views/sign_in_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_cubit.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_state.dart';
import 'package:mutazan_plus/features/auth/presentation/widgets/sign_in/custom_signin_form.dart';
import 'package:mutazan_plus/features/auth/presentation/widgets/welcome_banner.dart';
import 'package:mutazan_plus/features/auth/presentation/widgets/welcome_text_widget.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (_) => getIt<UserCubit>(),
      child: BlocListener<UserCubit, UserState>(
        listener: (context, state) {
          if (state is SignInSuccess) {
            print('✅ تسجيل الدخول ناجح');
            context.go('/homeView');
            // GoRouter.of(context).go('/companyScreen');
          } else if (state is SignInFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          }
        },
        child: Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              const SliverToBoxAdapter(child: WelcomeBanner()),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
              const SliverToBoxAdapter(
                child: WelcomeTextWidget(text: AppStrings.welcome),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const CustomSignInForm(),
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 16)),
            ],
          ),
        ),
      ),
    );
  }
}
