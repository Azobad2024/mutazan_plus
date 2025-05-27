import 'package:mutazan_plus/features/auth/data/models/user_model.dart';

class UserState {}

final class UserInitial extends UserState {}

final class SignInSuccess extends UserState {}

final class SignInLoading extends UserState {}

final class SignInFailure extends UserState {
  final String errMessage;

  SignInFailure( this.errMessage);
}

class PasswordVisibilityChanged extends UserState {}


final class GetUserSuccess extends UserState {
  final UserModel user;

  GetUserSuccess({required this.user});
}

final class GetUserLoading extends UserState {}

final class GetUserFailure extends UserState {
  final String errMessage;

  GetUserFailure({required this.errMessage});
}