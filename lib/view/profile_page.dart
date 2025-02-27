import 'dart:io';
import 'package:flutter/material.dart';
import '../constants.dart';

class ProfilePage1 extends StatefulWidget {
  const ProfilePage1({Key? key}) : super(key: key);
  static String routeName = "/ProfilePage1";

  @override
  State<ProfilePage1> createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage1> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColorAppBar,

      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: screenHeight * 0.4,
              child: const _TopPortion(),
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
  const _TopPortion({Key? key}) : super(key: key);

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
                  colors: [Color(0xff334E68), Color(0xff829AB1)]),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                bottomRight: Radius.circular(50),
              )),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Center(
            child: CircleAvatar(
              radius: 75,
              backgroundImage: const AssetImage('assets/images/myProfile.png'),
            ),
          ),
        ),
      ],
    );
  }
}

class _UserInfoCard extends StatelessWidget {
  const _UserInfoCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: const [
            _UserInfoRow(icon: Icons.person, label: "اسم المستخدم", value: "abdelazeez"),
            Divider(),
            _UserInfoRow(icon: Icons.phone, label: "رقم الهاتف", value: "770571954"),
            Divider(),
            _UserInfoRow(icon: Icons.location_on, label: "العنوان", value: "صنعاء، اليمن"),
            Divider(),
            _UserInfoRow(icon: Icons.email, label: "البريد الإلكتروني", value: "abdelazeez@example.com"),
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

  const _UserInfoRow({Key? key, required this.icon, required this.label, required this.value}) : super(key: key);

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


// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../constants.dart';
//
// class ProfilePage1 extends StatefulWidget {
//   const ProfilePage1({Key? key}) : super(key: key);
//   static String routeName = "/ProfilePage1";
//
//   @override
//   State<ProfilePage1> createState() => _ProfilePage1State();
// }
//
// class _ProfilePage1State extends State<ProfilePage1> {
//   File? _imageFile; // متغير لتخزين الصورة المختارة
//
//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
//
//     if (pickedFile != null) {
//       setState(() {
//         _imageFile = File(pickedFile.path); // حفظ الصورة المختارة
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double screenHeight = MediaQuery.of(context).size.height; // الحصول على ارتفاع الشاشة
//
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             // ✅ جعل الجزء العلوي يأخذ 40% من الشاشة
//             SizedBox(
//               height: screenHeight * 0.4,
//               child: _TopPortion(
//                 imageFile: _imageFile,
//                 pickImage: _pickImage,
//               ),
//             ),
//             const SizedBox(height: 16),
//             // ✅ إضافة النص أسفل الصورة
//             Text(
//               "Abdelazeez Obad",
//               style: Theme.of(context)
//                   .textTheme
//                   .titleLarge
//                   ?.copyWith(fontWeight: FontWeight.bold),
//             ),
//             const SizedBox(height: 16),
//             // ✅ إضافة بيانات المستخدم
//             const _UserInfoCard(), // كارت المعلومات
//             const Spacer(), // يترك فراغًا في الأسفل
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class _TopPortion extends StatelessWidget {
//   final File? imageFile;
//   final VoidCallback pickImage;
//
//   const _TopPortion({Key? key, required this.imageFile, required this.pickImage}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Container(
//           margin: const EdgeInsets.only(bottom: 50),
//           decoration:  BoxDecoration(
//               gradient: LinearGradient(
//                   begin: Alignment.bottomCenter,
//                   end: Alignment.topCenter,
//                   colors:[Color(0xff0043ba), Color(0xff006df1)]),
//               borderRadius: BorderRadius.only(
//                 bottomLeft: Radius.circular(50),
//                 bottomRight: Radius.circular(50),
//               )),
//         ),
//         // ✅ ضبط موضع الصورة بحيث تبقى ظاهرة جزئيًا
//         Positioned(
//           bottom: 0,
//           left: 0,
//           right: 0,
//           child: Center(
//             child: Stack(
//               children: [
//                 CircleAvatar(
//                   radius: 75,
//                   backgroundImage: imageFile != null
//                       ? FileImage(imageFile!) // إذا تم تحديد صورة، استخدمها
//                       : const AssetImage('assets/images/myProfile.png') as ImageProvider,
//                 ),
//                 Positioned(
//                   bottom: 0,
//                   right: 0,
//                   child: InkWell(
//                     onTap: pickImage,
//                     child: CircleAvatar(
//                       radius: 20,
//                       backgroundColor: Colors.blue,
//                       child: const Icon(
//                         Icons.camera_alt,
//                         color: Colors.white,
//                         size: 20,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
//
// // ✅ ويدجت خاصة بمعلومات المستخدم
// class _UserInfoCard extends StatelessWidget {
//   const _UserInfoCard({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 20),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       elevation: 4, // تأثير ظل للكارت
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: const [
//             _UserInfoRow(icon: Icons.person, label: "اسم المستخدم", value: "abdelazeez"),
//             Divider(),
//             _UserInfoRow(icon: Icons.phone, label: "رقم الهاتف", value: "770571954"),
//             Divider(),
//             _UserInfoRow(icon: Icons.location_on, label: "العنوان", value: "صنعاء، اليمن"),
//             Divider(),
//             _UserInfoRow(icon: Icons.email, label: "البريد الإلكتروني", value: "abdelazeez@example.com"),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// // ✅ عنصر منفصل لكل معلومة مع أيقونة
// class _UserInfoRow extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final String value;
//
//   const _UserInfoRow({Key? key, required this.icon, required this.label, required this.value}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(icon, color: Colors.blue, size: 28), // أيقونة
//         const SizedBox(width: 10),
//         Text(
//           "$label: ",
//           style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//         ),
//         Expanded(
//           child: Text(
//             value,
//             style: const TextStyle(fontSize: 16),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }
//
//
//
//
//
//
