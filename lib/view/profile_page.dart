import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage1 extends StatefulWidget {
  const ProfilePage1({super.key});
  // static String routeName = "/ProfilePage1";

  @override
  State<ProfilePage1> createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage1> {
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.backgroundColorAppBar,
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.4,
              child:
                  _TopPortion(imageFile: _imageFile, onCameraTap: _pickImage),
            ),
            const SizedBox(height: 16),
            Text(
              "Abdelazeez Obad",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(fontWeight: FontWeight.bold),
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

  const _TopPortion({this.imageFile, required this.onCameraTap});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(bottom: 50),
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Color(0xff334E68), Color(0xff829AB1)],
            ),
            borderRadius: BorderRadius.only(
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
                  radius: 75,
                  backgroundImage: imageFile != null
                      ? FileImage(imageFile!)
                      : const AssetImage('assets/images/myProfile.png')
                          as ImageProvider,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: onCameraTap,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.blue.shade700,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 24,
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            _UserInfoRow(
                icon: Icons.person, label: "username", value: "abdelazeez"),
            Divider(),
            _UserInfoRow(
                icon: Icons.phone, label: "phoneNumber", value: "770571954"),
            Divider(),
            _UserInfoRow(
                icon: Icons.location_on, label: "address", value: "sanaaYemen"),
            Divider(),
            _UserInfoRow(
                icon: Icons.email,
                label: "email",
                value: "abdelazeez@example.com"),
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

  const _UserInfoRow(
      {required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.blue, size: 28),
        const SizedBox(width: 10),
        Text(
          "$label: ",
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 16),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
