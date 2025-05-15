// lib/features/company/domain/usecases/get_companies.dart
import 'package:dartz/dartz.dart';
import 'package:mutazan_plus/features/company/domain/entities/company_entitiy.dart';
import '../../../../../core/errors/failure.dart';
import '../repositories/company_repository.dart';

class GetCompanies {
  final CompanyRepository repository;
  GetCompanies(this.repository);
  Future<Either<Failure, List<CompanyEntity>>> call() {
    return repository.getCompanies();
  }
}



// import 'package:dartz/dartz.dart';
// import 'package:mutazan_plus/features/company/domain/entities/company_entitiy.dart';
// import '../../../../core/errors/failure.dart';
// import '../repositories/company_repository.dart';

// class GetCompanies {
//   final CompanyRepository repository;
//   GetCompanies(this.repository);

//   Future<Either<Failure, List<CompanyEntity>>> call() {
//     return repository.getCompanies();
//   }
// }



// import 'package:dartz/dartz.dart';

// import '../../../../core/errors/failure.dart';
// import '../entities/company_entitiy.dart';
// import '../repositories/company_repository.dart';

// class GetCompany {
//   final CompanyRepository repository;

//   GetCompany({required this.repository});

//   Future<Either<Failure, List<CompanyEntity>>> call() {
//     return repository.getCompanies();
//   }
// } 
