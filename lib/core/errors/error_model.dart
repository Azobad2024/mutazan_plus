import 'package:mutazan_plus/core/databases/api/end_points.dart';

class ErrorModel {
  // final int status;
  final String detail;

  ErrorModel({ required this.detail});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      // status: jsonData[ApiKey.status]?? 0,
      detail: jsonData[ApiKey.detail]?? 'Unknown Error' ,
    );
  }

  String? get errorMessage => null;
}