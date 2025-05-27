import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:mutazan_plus/core/widgets/custom_navbar.dart';
import 'package:mutazan_plus/features/auth/data/models/user_model.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_cubit.dart';
import 'package:mutazan_plus/features/auth/presentation/cubit/user_state.dart';
import 'package:mutazan_plus/features/home/presentation/cubit/home_cubit.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;

class ProfilePage1 extends StatefulWidget {
  const ProfilePage1({Key? key}) : super(key: key);

  @override
  State<ProfilePage1> createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage1> {
  File? _imageFile;
  final _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    // جلب بيانات المستخدم
    context.read<UserCubit>().getUserProfile();
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) setState(() => _imageFile = File(picked.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        title: Text(
          AppStrings.profile.tr,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocBuilder<UserCubit, UserState>(
        builder: (ctx, state) {
          if (state is GetUserLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetUserFailure) {
            return Center(child: Text(state.errMessage));
          }
          final user = (state as GetUserSuccess).user;
          return _buildProfile(context, user);
        },
      ),
      bottomNavigationBar: BlocBuilder<NavCubit, int>(
        builder: (context, selectedIndex) {
          return Container(
            color:Theme.of(context).canvasColor,
            // padding: const EdgeInsets.symmetric(vertical: 8),
            child: NavigationBarItems(
              showBarcode: false,
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfile(BuildContext context, UserModel user) {
    final theme = Theme.of(context);
    final height = MediaQuery.of(context).size.height;
    final avatarRadius = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 75,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.TABLET, value: 100),
      ],
    ).value!;

    final sectionSpacing = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 16,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.TABLET, value: 24),
      ],
    ).value!;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: height * 0.4,
            child: _TopPortion(
              imageFile: _imageFile,
              remotePicUrl: user.profilePic,
              avatarRadius: avatarRadius,
              onCameraTap: _pickImage,
            ),
          ),
          SizedBox(height: sectionSpacing),
          Text(
            user.name,
            style: theme.textTheme.headlineSmall!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: sectionSpacing),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: responsive.ResponsiveValue<double>(
                context,
                defaultValue: 20,
                conditionalValues: [
                  responsive.Condition.largerThan(name: responsive.TABLET, value: 40),
                ],
              ).value!,
            ),
            child: _UserInfoCard(user: user),
          ),
        ],
      ),
    );
  }
}

class _TopPortion extends StatelessWidget {
  final File? imageFile;
  final String remotePicUrl;
  final double avatarRadius;
  final VoidCallback onCameraTap;

  const _TopPortion({
    this.imageFile,
    required this.remotePicUrl,
    required this.avatarRadius,
    required this.onCameraTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final grad = LinearGradient(
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      colors: [
        AppColors.backgroundColorAppBar,
        AppColors.container1Color,
      ],
    );
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: BoxDecoration(
            gradient: grad,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile!)
                      : (remotePicUrl.isNotEmpty
                          ? NetworkImage("${EndPoint.baseUrl}$remotePicUrl")
                          : const AssetImage('assets/images/myProfile.png')
                              as ImageProvider),
                ),
                Positioned(
                  bottom: 0,
                  right: avatarRadius * 0.1,
                  child: GestureDetector(
                    onTap: onCameraTap,
                    child: Container(
                      padding: EdgeInsets.all(avatarRadius * 0.1),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: theme.colorScheme.secondary,
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        color: theme.colorScheme.onSecondary,
                        size: avatarRadius * 0.3,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _UserInfoCard extends StatelessWidget {
  final UserModel user;
  const _UserInfoCard({required this.user});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: theme.cardColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: responsive.ResponsiveValue<double>(
            context,
            defaultValue: 16,
            conditionalValues: [
              responsive.Condition.largerThan(name: responsive.TABLET, value: 24),
            ],
          ).value,
          horizontal: responsive.ResponsiveValue<double>(
            context,
            defaultValue: 16,
            conditionalValues: [
              responsive.Condition.largerThan(name: responsive.TABLET, value: 24),
            ],
          ).value,
        ),
        child: Column(
          children: [
            _Row(
              icon: Icons.person,
              label: AppStrings.username.tr,
              value: user.name,
            ),
            Divider(color: theme.dividerColor),
            _Row(
              icon: Icons.email,
              label: AppStrings.email.tr,
              value: user.email,
            ),
            Divider(color: theme.dividerColor),
            _Row(
              icon: Icons.phone,
              label: AppStrings.phoneNumber.tr,
              value: user.phone,
            ),
            Divider(color: theme.dividerColor),
            _Row(
              icon: Icons.location_on,
              label: AppStrings.address.tr,
              value: user.address,
            ),
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _Row({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconSize = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 24,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.TABLET, value: 28),
      ],
    ).value!;

    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: responsive.ResponsiveValue<double>(
          context,
          defaultValue: 8,
          conditionalValues: [
            responsive.Condition.largerThan(name: responsive.TABLET, value: 12),
          ],
        ).value!,
      ),
      child: Row(
        children: [
          Icon(icon, color: theme.colorScheme.primary, size: iconSize),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: theme.textTheme.bodyMedium!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.bodyMedium,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}


