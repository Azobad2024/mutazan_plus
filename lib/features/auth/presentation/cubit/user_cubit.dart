import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mutazan_plus/features/auth/data/repositories/user_repository.dart';
import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository repo;
  bool obscurePassword = true;
  final signInFormKey = GlobalKey<FormState>();
  final signInUsername  = TextEditingController();
  final signInPassword  = TextEditingController();

  UserCubit(this.repo) : super(UserInitial());

  void changePasswordVisibility() {
    obscurePassword = !obscurePassword;
    emit(PasswordVisibilityChanged());
  }

  Future<void> signIn() async {
    if (!signInFormKey.currentState!.validate()) return;
    emit(SignInLoading());
    final result = await repo.signIn(
      username: signInUsername.text.trim(),
      password: signInPassword.text,
    );
    result.fold(
      (err)  => emit(SignInFailure(err)),
      (_)    => emit(SignInSuccess()),
    );
  }
}
