import 'package:mutazan_plus/core/databases/api/end_points.dart';

class SignInModel {
  final String refresh;
  final String access;

  SignInModel({required this.access, required this.refresh});

  factory SignInModel.fromJson(Map<String, dynamic> jsonData) {
    return SignInModel(
      access: jsonData[ApiKey.access] ?? '',
      refresh: jsonData[ApiKey.refresh] ?? '',
    );
  }
}
