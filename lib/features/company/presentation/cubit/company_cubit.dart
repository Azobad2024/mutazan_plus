// lib/features/company/presentation/cubit/company_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:mutazan_plus/core/utils/app_colors.dart';
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

void showTopSnackBar(
  BuildContext context, {
  required String message,
  Color? backgroundColor,
  Duration duration = const Duration(seconds: 3),
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 8,
        left: 16,
        right: 16,
        bottom: 10,
      ),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
      backgroundColor:
          (backgroundColor ?? AppColors.error).withOpacity(0.9),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Text(
        message,
        style: const TextStyle(color: Colors.white, fontSize: 14),
      ),
      duration: duration,
    ),
  );
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
