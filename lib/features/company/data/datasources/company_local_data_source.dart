// lib/features/company/data/datasources/company_local_data_source.dart

import 'dart:convert';
import '../../../../../core/databases/cache/cache_helper.dart';
import '../models/company_model.dart';

class CompanyLocalDataSource {
  static const _cacheKey = 'CACHED_COMPANIES';
  final CacheHelper cache;

  CompanyLocalDataSource(this.cache);

// تقوم بتحويل قائمة الشركات إلى JSON وتخزينها في التخزين المحلي
  Future<void> cacheCompanies(List<CompanyModel> list) async {
    final jsonList = list.map((m) => m.toJson()).toList();
    await cache.saveData(key: _cacheKey, value: json.encode(jsonList));
  }

  Future<List<CompanyModel>> getLastCompanies() async {
    final jsonString = cache.getDataString(_cacheKey);
    if (jsonString != null && jsonString.isNotEmpty) {
      try {
        final decoded = json.decode(jsonString) as List;
        return decoded
            .map((e) => CompanyModel.fromJson(e as Map<String, dynamic>))
            .toList();
      } catch (_) {
        // إذا فشل التحويل، نمسح الكاش كي لا نعيد الخطأ
        await cache.removeData(key: _cacheKey);
      }
    }
    return [];
  }
}
