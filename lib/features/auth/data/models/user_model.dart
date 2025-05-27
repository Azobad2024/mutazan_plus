import 'package:mutazan_plus/core/databases/api/end_points.dart';

// class UserModel {
//   final String profilePic;
//   final String email;
//   final String phone;
//   final String name;
//   final String address;

//   UserModel({
//     required this.profilePic,
//     required this.email,
//     required this.phone,
//     required this.name,
//     required this.address,
//   });

//   factory UserModel.fromJson(Map<String, dynamic> jsonData) {
//     return UserModel(
//       profilePic: jsonData[ApiKey.profilePic],
//       email: jsonData['user'][ApiKey.email],
//       phone: jsonData[ApiKey.phoneNumber],
//       name: jsonData['user'][ApiKey.username],
//       address: jsonData[ApiKey.address    ],
//     );
//   }
// }
class UserModel {
  final String profilePic;
  final String email;
  final String phone;
  final String name;
  final String address;

  UserModel({
    required this.profilePic,
    required this.email,
    required this.phone,
    required this.name,
    required this.address,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      // يستخدم المفتاح profile_picture
      profilePic: json[ApiKey.profilePic] as String,
      // داخل الحقل user تجد username & email
      name: json['user'][ApiKey.username] as String,
      email: json['user'][ApiKey.email] as String,
      phone: json[ApiKey.phoneNumber] as String,
      address: json[ApiKey.address] as String,
    );
  }
}
