// lib/features/company/data/datasources/company_remote_data_source.dart
import '../../../../../core/databases/api/api_consumer.dart';
import '../../../../../core/databases/api/end_points.dart';
import '../models/company_model.dart';

class CompanyRemoteDataSource {
  final ApiConsumer api;
  CompanyRemoteDataSource(this.api);
  Future<List<CompanyModel>> getCompanies() async {
    final response = await api.get(EndPoint.companies);
    return (response as List)
        .map((e) => CompanyModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}





// import '../../../../core/databases/api/api_consumer.dart';
// import '../../../../core/databases/api/end_points.dart';
// import '../models/company_model.dart';

// class CompanyRemoteDataSource {
//   final ApiConsumer api;
//   CompanyRemoteDataSource(this.api);

//   Future<List<CompanyModel>> getCompanies() async {
//     final response = await api.get(EndPoint.companies);
//     // نتوقع response كـ List<dynamic>
//     return (response as List)
//         .map((json) => CompanyModel.fromJson(json as Map<String, dynamic>))
//         .toList();
//   }
// }






// import '../../../../core/databases/api/api_consumer.dart';
// import '../../../../core/databases/api/end_points.dart';
// import '../models/company_model.dart';

// class CompanyRemoteDataSource {
//   late final ApiConsumer api;
//   Future<List<CompanyModel>> getCompanies() async {
//     final response = await api.get(EndPoint.companies);
//     // نتوقع response كـ List<dynamic>
//     return (response as List)
//         .map((json) => CompanyModel.fromJson(json as Map<String, dynamic>))
//         .toList();
//   }
// }





// // class CompanyRemoteDataSource {
// //   final ApiConsumer api;

// //   CompanyRemoteDataSource({required this.api});
// //   Future<CompanyModel> getCompany(CompanyParams params) async {
// //     final response = await api.get("${EndPoint.companies}/${params.id}");
// //     return CompanyModel.fromJson(response);
// //   }

// //   getCompanies() {}
// // }
