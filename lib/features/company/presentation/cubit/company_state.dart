// lib/features/company/presentation/cubit/company_state.dart
import 'package:equatable/equatable.dart';
import 'package:mutazan_plus/features/company/domain/entities/company_entitiy.dart';

abstract class CompanyState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CompanyInitial extends CompanyState {}

class CompanyLoading extends CompanyState {}

class CompanySuccess extends CompanyState {
  final List<CompanyEntity> companies;
  CompanySuccess(this.companies);
  @override
  List<Object?> get props => [companies];
}

class CompanyFailure extends CompanyState {
  final String message;
  CompanyFailure(this.message);
  @override
  List<Object?> get props => [message];
}






// import 'package:equatable/equatable.dart';
// import '../../domain/entities/company_entitiy.dart';



// abstract class CompanyState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class CompanyInitial extends CompanyState {}

// class CompanyLoading extends CompanyState {}

// class CompanySuccess extends CompanyState {
//   final List<CompanyEntity> companies;
//   CompanySuccess(this.companies);

//   @override
//   List<Object?> get props => [companies];
// }

// class CompanyFailure extends CompanyState {
//   final String message;
//   CompanyFailure(this.message);

//   @override
//   List<Object?> get props => [message];
// }



// abstract class CompanyState extends Equatable {
//   @override
//   List<Object?> get props => [];
// }

// class CompanyInitial extends CompanyState {}

// class CompanyLoading extends CompanyState {}

// class CompanySuccess extends CompanyState {
//   final CompanyEntity company;
//   CompanySuccess(this.company);
//   @override
//   List<Object?> get props => [company];
// }

// class CompanyFailure extends CompanyState {
//   final String error;
//   CompanyFailure(this.error, {required String errMessage});
//   @override
//   List<Object?> get props => [error];
// }
