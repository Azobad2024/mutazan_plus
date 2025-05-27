// import 'package:mutazan_plus/features/company/domain/entities/company_entitiy.dart';

// import '../../../../core/databases/api/end_points.dart';

// class CompanyModel extends CompanyEntity {
//   final int id;
//   CompanyModel({
//     required this.id,
//     required super.companyName,
//     required super.logo,
//     required super.active,
//     required super.schemaName,
//   });
//   factory CompanyModel.fromJson(Map<String, dynamic> json) {
//     return CompanyModel(
//       id: json[ApiKey.id],
//       schemaName: json[ApiKey.schemaName],    // ← هنا
//       companyName: json[ApiKey.companyName],
//       logo: json[ApiKey.logo],
//       active: json[ApiKey.active].toString(),
//     );
//   }
//   Map<String, dynamic> toJson() => {
//         ApiKey.id: id,
//         ApiKey.companyName: companyName,
//         ApiKey.logo: logo,
//         ApiKey.active: active,
//       };
// }

import 'package:mutazan_plus/core/databases/api/end_points.dart';

import '../../domain/entities/company_entitiy.dart';

class CompanyModel extends CompanyEntity {
  final int id;
  final String businessType;
  final String registrationNumber;
  final String country;
  final String address;
  final String phoneNumber;
  final String email;
  final String employeesCount;
  final String foundedDate;
  final String servicesOffered;
  final String portLicenseNumber;
  final String createdAt;
  final String adminUser;

  CompanyModel({
    required super.companyName,
    required super.logo,
    required super.active,
    required super.schemaName,
    required this.id,
    required this.registrationNumber,
    required this.businessType,
    required this.country,
    required this.address,
    required this.phoneNumber,
    required this.email,
    required this.employeesCount,
    required this.foundedDate,
    required this.servicesOffered,
    required this.portLicenseNumber,
    required this.createdAt,
    required this.adminUser,
  });

  /// 🡺 fromJson: تحويل من JSON إلى كائن Dart
  factory CompanyModel.fromJson(Map<String, dynamic> json) {
    // تصحيح مسار الشعار:
    final rawLogo = json[ApiKey.logo] as String? ?? '';
    final fullLogo =
        rawLogo.startsWith('http') ? rawLogo : "${EndPoint.baseUrl}$rawLogo";

    return CompanyModel(
      id: json[ApiKey.companyId] as int? ?? 0,
      companyName: json[ApiKey.companyName] as String? ?? '',
      logo: fullLogo,
      active: json[ApiKey.active] as String? ?? 'false',
      schemaName: json[ApiKey.schemaName] as String? ?? '',
      businessType: json[ApiKey.businessType] as String? ?? '',
      registrationNumber: "${json[ApiKey.registrationNumber]}",
      country: json[ApiKey.country] as String? ?? '',
      address: json[ApiKey.address] as String? ?? '',
      phoneNumber: json[ApiKey.phoneNumber] as String? ?? '',
      email: json[ApiKey.email] as String? ?? '',
      employeesCount: "${json[ApiKey.employeesCount]}",
      foundedDate: json[ApiKey.foundedDate] as String? ?? '',
      servicesOffered: json[ApiKey.servicesOffered] as String? ?? '',
      portLicenseNumber: "${json[ApiKey.portLicenseNumber]}",
      createdAt: json[ApiKey.createdAt] as String? ?? '',
      adminUser: "${json[ApiKey.adminUser]}",
    );
  }

  Map<String, dynamic> toJson() {
    // خزِّن كل الحقول كي يعمل الكاش بكامله
    return {
      ApiKey.companyId: id,
      ApiKey.companyName: companyName,
      ApiKey.logo: logo,
      ApiKey.active: active,
      ApiKey.schemaName: schemaName,
      ApiKey.businessType: businessType,
      ApiKey.registrationNumber: registrationNumber,
      ApiKey.country: country,
      ApiKey.address: address,
      ApiKey.phoneNumber: phoneNumber,
      ApiKey.email: email,
      ApiKey.employeesCount: employeesCount,
      ApiKey.foundedDate: foundedDate,
      ApiKey.servicesOffered: servicesOffered,
      ApiKey.portLicenseNumber: portLicenseNumber,
      ApiKey.createdAt: createdAt,
      ApiKey.adminUser: adminUser,
    };

    // factory CompanyModel.fromJson(Map<String, dynamic> json) {
    //   return CompanyModel(
    //     id: json[ApiKey.id],
    //     companyName: json[ApiKey.companyName],
    //     logo: json[ApiKey.logo],
    //     active: json[ApiKey.active],
    //     schemaName: json[ApiKey.schemaName],
    //     businessType: json[ApiKey.businessType],
    //     registrationNumber: json[ApiKey.registrationNumber],
    //     country: json[ApiKey.country],
    //     address: json[ApiKey.address],
    //     phoneNumber: json[ApiKey.phoneNumber],
    //     email: json[ApiKey.email],
    //     employeesCount: json[ApiKey.employeesCount],
    //     foundedDate: json[ApiKey.foundedDate],
    //     servicesOffered: json[ApiKey.servicesOffered],
    //     portLicenseNumber: json[ApiKey.portLicenseNumber],
    //     createdAt: json[ApiKey.createdAt],
    //     adminUser: json[ApiKey.adminUser],
    //   );
    // }

    // Map<String, dynamic> toJson() {
    //   return {
    //     ApiKey.id: id,
    //     ApiKey.companyName: companyName,
    //     ApiKey.logo : logo,
    //     ApiKey.active : active,
    //     ApiKey.schemaName : schemaName,
    //     ApiKey.businessType : businessType,
    //     ApiKey.registrationNumber : registrationNumber,
    //     ApiKey.country : country,
    //     ApiKey.address : address,
    //     ApiKey.phoneNumber : phoneNumber,
    //     ApiKey.email : email,
    //     ApiKey.employeesCount : employeesCount,
    //     ApiKey.foundedDate : foundedDate,
    //     ApiKey.servicesOffered : servicesOffered,
    //     ApiKey.portLicenseNumber : portLicenseNumber,
    //     ApiKey.createdAt : createdAt,
    //     ApiKey.adminUser : adminUser,
    //   };
  }
}
