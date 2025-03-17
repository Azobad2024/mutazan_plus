import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';

class CompanyController extends GetxController {
  var companies = <Company>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchCompanies();
  }

  Future<void> fetchCompanies() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://192.168.150.162:8000/api/companies/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = await compute(parseJson, response.body);
        companies.value = data.map((json) => Company.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load companies');
      }
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }
}

List<dynamic> parseJson(String responseBody) {
  return jsonDecode(responseBody) as List<dynamic>;
}

class Company {
  String companyName;
  String logo;
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



// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// class CompanyController extends GetxController {
//   var companies = <Company>[].obs; // قائمة الشركات كـ Observable
//   var isLoading = true.obs; // حالة التحميل
//
//   @override
//   void onInit() {
//     super.onInit();
//     fetchCompanies(); // جلب البيانات عند تهيئة الـ Controller
//   }
//
//   // دالة لجلب بيانات الشركات من API
//   Future<void> fetchCompanies() async {
//     try {
//       isLoading(true); // بدء التحميل
//       final response = await http.get(Uri.parse('https://api.opencorporates.com/companies/nl/17087985'));
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         companies.value = data.map((company) => Company.fromJson(company)).toList();
//       } else {
//         throw Exception('Failed to load companies');
//       }
//     } catch (e) {
//       Get.snackbar('Error', e.toString()); // عرض خطأ للمستخدم
//     } finally {
//       isLoading(false); // إيقاف التحميل
//     }
//   }
// }
//
// // نموذج بيانات الشركة
// class Company {
//   final String name;
//   final String imagePath;
//   final bool isActive;
//
//   Company({
//     required this.name,
//     required this.imagePath,
//     required this.isActive,
//   });
//
//   factory Company.fromJson(Map<String, dynamic> json) {
//     return Company(
//       name: json['name'],
//       imagePath: json['imagePath'],
//       isActive: json['isActive'],
//     );
//   }
// }