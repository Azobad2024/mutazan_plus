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

