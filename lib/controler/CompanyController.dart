import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

import '../model/company_model.dart';

class CompanyController extends GetxController {
  var companies = <Company>[].obs;
  var isLoading = true.obs;
  late Box<Company> companyBox;

  @override
  void onInit() {
    super.onInit();
    companyBox = Hive.box<Company>('companyBox'); // فتح صندوق Hive
    loadLocalCompanies(); // تحميل البيانات المحلية أولاً
    fetchCompanies(); // جلب البيانات من API
  }

  /// تحميل الشركات المخزنة محليًا
  void loadLocalCompanies() {
    final localCompanies = companyBox.values.toList();
    if (localCompanies.isNotEmpty) {
      companies.value = localCompanies;
    }
  }

  /// جلب بيانات الشركات من API وتحديث التخزين المحلي
  Future<void> fetchCompanies() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse('http://192.168.83.162:8000/api/companies/'));

      if (response.statusCode == 200) {
        final List<dynamic> data = await compute(parseJson, response.body);
        final List<Company> fetchedCompanies = data.map((json) => Company.fromJson(json)).toList();

        // تحديث الـ Observable list
        companies.value = fetchedCompanies;

        // تخزين البيانات محليًا في Hive
        companyBox.clear();
        companyBox.addAll(fetchedCompanies);
      } else {
        throw Exception('فشل تحميل بيانات الشركات');
      }
    } catch (e) {
      Get.snackbar('خطأ', e.toString());
    } finally {
      isLoading(false);
    }
  }
}

List<dynamic> parseJson(String responseBody) {
  return jsonDecode(responseBody) as List<dynamic>;
}