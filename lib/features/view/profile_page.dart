import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_framework.dart' as responsive;
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:mutazan_plus/core/utils/app_strings.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage1 extends StatefulWidget {
  const ProfilePage1({super.key});

  @override
  State<ProfilePage1> createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage1> {
  File? _imageFile;
  final _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.camera);
    if (picked != null) {
      setState(() => _imageFile = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final height = MediaQuery.of(context).size.height;
    final avatarRadius = responsive.ResponsiveValue<double>(
      context,
      defaultValue: 75,
      conditionalValues: [
        responsive.Condition.largerThan(name: responsive.TABLET, value: 100),
      ],
    ).value;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(backgroundColor: AppColors.container1Color),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.4,
              child: _TopPortion(
                imageFile: _imageFile,
                onCameraTap: _pickImage,
                avatarRadius: avatarRadius,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'abdelazeez obad', // بالإمكان استبدالها بمتغير للمستخدم
              style: theme.textTheme.headlineSmall!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            const _UserInfoCard(),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

class _TopPortion extends StatelessWidget {
  final File? imageFile;
  final VoidCallback onCameraTap;
  final double avatarRadius;

  const _TopPortion({
    this.imageFile,
    required this.onCameraTap,
    required this.avatarRadius,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradient = LinearGradient(
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
            gradient: gradient,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            ),
          ),
        ),
        Positioned(
          bottom: 0, left: 0, right: 0,
          child: Center(
            child: Stack(
              children: [
                CircleAvatar(
                  radius: avatarRadius,
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile!)
                      : const AssetImage('assets/images/myProfile.png')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0, right: 4,
                  child: GestureDetector(
                    onTap: onCameraTap,
                    child: Container(
                      padding: const EdgeInsets.all(8),
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
  const _UserInfoCard();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      color: theme.cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _UserInfoRow(
              icon: Icons.person,
              label: AppStrings.username.tr,
              value: 'abdelazeez',
            ),
            Divider(color: theme.dividerColor),
            _UserInfoRow(
              icon: Icons.phone,
              label: AppStrings.phoneNumber.tr,
              value: '770571954',
            ),
            Divider(color: theme.dividerColor),
            _UserInfoRow(
              icon: Icons.location_on,
              label: AppStrings.address.tr,
              value: AppStrings.sanaaYemen.tr,
            ),
            Divider(color: theme.dividerColor),
            _UserInfoRow(
              icon: Icons.email,
              label: AppStrings.email.tr,
              value: 'abdelazeez@example.com',
            ),
          ],
        ),
      ),
    );
  }
}

class _UserInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _UserInfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final iconColor = theme.colorScheme.primary;
    final textStyle = theme.textTheme.bodyMedium;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: iconColor, size: 24),
          const SizedBox(width: 12),
          Text(
            '$label: ',
            style: textStyle?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: textStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
