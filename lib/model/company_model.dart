import 'package:hive/hive.dart';

part 'company_model.g.dart'; // ✅ مهم لتوليد كود التهيئة

@HiveType(typeId: 0)
class Company extends HiveObject {
  @HiveField(0)
  String companyName;

  @HiveField(1)
  String logo;

  @HiveField(2)
  String country;

  Company({
    required this.companyName,
    required this.logo,
    required this.country,
  });

  factory Company.fromJson(Map<String, dynamic> json) {
    return Company(
      companyName: json['company_name'],
      logo: json['logo'],
      country: json['country'],
    );
  }
}