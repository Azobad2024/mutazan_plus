import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:mutazan_plus/core/functions/navigation.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/widgets/container_radius.dart';
import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';
import 'package:mutazan_plus/features/theme/bloc/theme_bloc.dart';
import '../controler/language_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final LanguageController languageController = Get.put(LanguageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        automaticallyImplyLeading: false,
        title: Text(
          'settings'.tr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
    
      // نلف الـ body داخل ContainerRadius
      body: SafeArea(
        child: ContainerRadius(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: ListTile(
                  leading: const Icon(Icons.language),
                  title: Text('language'.tr),
                  trailing: Obx(() => DropdownButton<bool>(
                        value: languageController.isArabic.value,
                        items: [
                          DropdownMenuItem(
                            value: true,
                            child: Text('العربية'),
                          ),
                          DropdownMenuItem(
                            value: false,
                            child: Text('English'),
                          ),
                        ],
                        onChanged: (v) {
                          if (v != null) {
                            languageController.changeLanguage(
                              v ? AppLanguage.arabic : AppLanguage.english,
                            );
                          }
                        },
                      )),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.dark_mode),
                  title: Text('theme'.tr),
                  // نستخدم BlocBuilder لقراءة حالة الثيم
                  trailing: BlocBuilder<ThemeBloc, ThemeState>(
                    builder: (context, state) {
                      final isDark = state is DarkThemeState;
                      return Switch.adaptive(
                        value: isDark,
                        onChanged: (val) {
                          // أرسل الحدث لتغيير الثيم
                          context
                              .read<ThemeBloc>()
                              .add(ChangeThemeEvent(isDark: val));
                        },
                      );
                    },
                  ),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.notifications),
                  title: Text('notifications'.tr),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {/* TODO: إعدادات الإشعارات */},
                ),
              ),
              const SizedBox(height: 20),
              Card(
                color: Colors.redAccent,
                child: ListTile(
                  leading: const Icon(Icons.logout, color: Colors.white),
                  title: Text(
                    'logout'.tr,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onTap: () => customReplacementNavigateAll(
                    context,
                    '/signIn',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    
      // شريط التنقل السفلي مع BlocBuilder لقراءة selectedIndex من NavCubit
      bottomNavigationBar: BlocBuilder<NavCubit, int>(
        builder: (context, selectedIndex) {
          return Container(
            color:Theme.of(context).canvasColor,
            // padding: const EdgeInsets.symmetric(vertical: 0),
            child: NavigationBarItems(
              // selectedIndex: selectedIndex,
              showBarcode: false,
            ),
          );
        },
      ),
    );
  }
}
