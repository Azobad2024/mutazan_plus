// lib/features/company/presentation/cubit/company_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mutazan_plus/features/company/domain/entities/company_entitiy.dart';
import 'package:mutazan_plus/features/company/domain/usecases/get_company.dart';
import '../../../../../core/errors/failure.dart';
import 'company_state.dart';

class CompanyCubit extends Cubit<CompanyState> {
  final GetCompanies getCompanies;
  CompanyCubit({required this.getCompanies}) : super(CompanyInitial());


  Future<void> fetchCompanies() async {
    emit(CompanyLoading());
    final Either<Failure, List<CompanyEntity>> result = await getCompanies();
    result.fold(
      (f) => emit(CompanyFailure(f.errMessage)),
      (list) => emit(list.isEmpty
          ? CompanyFailure('لا توجد شركات متاحة')
          : CompanySuccess(list)),
    );
  }
}




// import 'package:bloc/bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:mutazan_plus/features/company/domain/entities/company_entitiy.dart';
// import 'package:mutazan_plus/features/company/domain/usecases/get_company.dart';
// import '../../../../core/errors/failure.dart';
// import 'company_state.dart';

// class CompanyCubit extends Cubit<CompanyState> {
//   final GetCompanies getCompanies;

//   CompanyCubit({required this.getCompanies}) : super(CompanyInitial());

//   Future<void> fetchCompanies() async {
//     emit(CompanyLoading());
//     final Either<Failure, List<CompanyEntity>> result = await getCompanies();
//     result.fold(
//       (failure) => emit(CompanyFailure(failure.errMessage)),
//       // (list)    => emit(CompanySuccess(list)),
//       (list) => emit(list.isEmpty
//       ? CompanyFailure('لا توجد شركات حالياً')
//       : CompanySuccess(list)),
//     );
//   }
// }




// import 'package:bloc/bloc.dart';
// import 'package:dartz/dartz.dart';
// import 'package:mutazan_plus/core/errors/failure.dart';
// import 'package:mutazan_plus/features/company/data/repositories/company_repository_impl.dart';
// import 'package:mutazan_plus/features/company/domain/entities/company_entitiy.dart';
// import 'package:mutazan_plus/features/company/domain/usecases/get_company.dart';
// import 'company_state.dart';

// class CompanyCubit extends Cubit<CompanyState> {
//   // CompanyCubit(super.initialState, this.companyRepositoryImpl);
//     // final CompanyRepositoryImpl companyRepositoryImpl;

//   //------------ get Company ---------------------

//   //   getCompany() async {
//   //   emit(CompanyLoading());
//   //   final response = await companyRepositoryImpl.getCompany();
//   //   response.fold(
//   //     (errMessage) => emit(CompanyFailure(errMessage : errMessage, errMessage)),
//   //     (company) => emit(CompanySuccess([company] as CompanyEntity)),
//   //   );
//   // }

//   final GetCompany getCompany;
//   final cacheHelper;
//   CompanyCubit(
//     super.initialState, 
//     {
//       // required this.companyRepositoryImpl, 
//     required this.getCompany,
//     required this.cacheHelper,
//   });

//   void fetchCompany(String id) async {
//     emit(CompanyLoading());
//     final Either<Failure, List<CompanyEntity>> result = await getCompany();
//     result.fold(
//       (failure) =>
//           emit(CompanyFailure(failure.errMessage, errMessage: 'ggggg')),
//       (company) {
//         emit(CompanySuccess(company as CompanyEntity));
//       },
//     );
//   }
// }
