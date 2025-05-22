import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:mutazan_plus/core/widgets/show_top_snack_bar.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;

import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/core/services/services_locator.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_cubit.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_state.dart';
import 'package:mutazan_plus/features/auth/presentation/widgets/sign_in/custom_signin_form.dart';
import 'package:mutazan_plus/features/auth/presentation/widgets/welcome_banner.dart';
import 'package:mutazan_plus/features/auth/presentation/widgets/welcome_text_widget.dart';
import 'package:responsive_framework/responsive_framework.dart';

class SignInView extends StatelessWidget {
  const SignInView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // استخرج لون البانر العلوي بنفس المنطق:
    final bannerTopColor = isDark
        ? theme.canvasColor
        : AppColors.backgroundColor.withOpacity(0.65);

    // اختر أيقونات شريط الحالة بناءً على التباين:
    final overlayStyle = SystemUiOverlayStyle(
      statusBarColor: bannerTopColor,
      statusBarIconBrightness: isDark ? Brightness.light : Brightness.light,
      statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
    );
    // responsive paddings
    final horizontalPad = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 24,
      conditionalValues: [
        responsive.Condition.smallerThan(name: responsive.MOBILE, value: 16),
        responsive.Condition.largerThan(name: responsive.TABLET, value: 32),
      ],
    ).value;
    final topBannerHeight = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 0.3,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.TABLET, value: 0.4),
      ],
    ).value;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: overlayStyle,
      child: BlocProvider<UserCubit>(
        create: (_) => getIt<UserCubit>(),
        child: BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is SignInSuccess) {
              context.go('/homeView');
            } else if (state is SignInFailure) {
              showTopSnackBar(
                context,
                message: state.errMessage,
                backgroundColor: theme.colorScheme.error,
              );
            }
          },
          child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
              backgroundColor: theme.scaffoldBackgroundColor,
              body: SafeArea(
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
                    // البانر الترحيبي
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height *
                            topBannerHeight,
                        child: const WelcomeBanner(),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                          height: responsive.ResponsiveValue<double>(context,
                              defaultValue: 16,
                              conditionalValues: [
                            responsive.Condition.largerThan(
                                name: responsive.TABLET, value: 32)
                          ]).value),
                    ),

                    // نص الترحيب
                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPad),
                        child: WelcomeTextWidget(
                          text: AppStrings.welcome.tr,
                        ),
                      ),
                    ),
                    SliverToBoxAdapter(
                      child: SizedBox(
                          height: responsive.ResponsiveValue<double>(context,
                              defaultValue: 16,
                              conditionalValues: [
                            responsive.Condition.largerThan(
                                name: responsive.TABLET, value: 32)
                          ]).value),
                    ),

                    // نموذج تسجيل الدخول داخل بطاقة

                    SliverToBoxAdapter(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: horizontalPad),
                        child: Card(
                          // إذا كان الثيم داكن استخدم canvasColor (كما في ContainerRadius)
                          // وإلا استخدم cardColor الافتراضي
                          color: theme.brightness == Brightness.dark
                              ? Theme.of(context).canvasColor
                              : theme.cardColor,
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(
                              responsive.ResponsiveValue<double>(
                                context,
                                defaultValue: 24,
                                conditionalValues: [
                                  responsive.Condition.largerThan(
                                      name: responsive.TABLET, value: 32),
                                ],
                              ).value,
                            ),
                            child: const CustomSignInForm(),
                          ),
                        ),
                      ),
                    ),

                    SliverToBoxAdapter(
                      child: SizedBox(
                          height: ResponsiveValue<double>(context,
                              defaultValue: 16,
                              conditionalValues: [
                            responsive.Condition.largerThan(
                                name: responsive.TABLET, value: 32)
                          ]).value),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// // lib/features/auth/presentation/views/sign_in_view.dart

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
// import 'package:mutazan_plus/core/services/services_locator.dart';
// import 'package:mutazan_plus/core/utils/app_strings.dart';
// import 'package:mutazan_plus/features/auth/presentation/cubit/user_cubit.dart';
// import 'package:mutazan_plus/features/auth/presentation/cubit/user_state.dart';
// import 'package:mutazan_plus/features/auth/presentation/widgets/sign_in/custom_signin_form.dart';
// import 'package:mutazan_plus/features/auth/presentation/widgets/welcome_banner.dart';
// import 'package:mutazan_plus/features/auth/presentation/widgets/welcome_text_widget.dart';

// class SignInView extends StatelessWidget {
//   const SignInView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider<UserCubit>(
//       create: (_) => getIt<UserCubit>(),
//       child: BlocListener<UserCubit, UserState>(
//         listener: (context, state) {
//           if (state is SignInSuccess) {
//             print('✅ تسجيل الدخول ناجح');
//             context.go('/homeView');
//             // GoRouter.of(context).go('/companyScreen');
//           } else if (state is SignInFailure) {
//             ScaffoldMessenger.of(context).showSnackBar(
//               SnackBar(content: Text(state.errMessage)),
//             );
//           }
//         },
//         child: Scaffold(
//           body: CustomScrollView(
//             physics: const BouncingScrollPhysics(),
//             slivers: [
//               const SliverToBoxAdapter(child: WelcomeBanner()),
//               const SliverToBoxAdapter(child: SizedBox(height: 32)),
//               const SliverToBoxAdapter(
//                 child: WelcomeTextWidget(text: AppStrings.welcome),
//               ),
//               SliverToBoxAdapter(
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                   child: const CustomSignInForm(),
//                 ),
//               ),
//               const SliverToBoxAdapter(child: SizedBox(height: 16)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
