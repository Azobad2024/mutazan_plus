import 'package:dartz/dartz.dart';
import 'package:mutazan_plus/features/company/domain/entities/company_entitiy.dart';
import '../../../../../core/errors/failure.dart';

abstract class CompanyRepository {
  Future<Either<Failure, List<CompanyEntity>>> getCompanies();
}

// import 'package:dartz/dartz.dart';
// import '../../../../core/errors/failure.dart';
// // import '../../../../core/params/params.dart';
// import '../entities/company_entitiy.dart';

// abstract class CompanyRepository {
//   Future<Either<Failure, List<CompanyEntity>>> getCompanies(
//   );
// }
