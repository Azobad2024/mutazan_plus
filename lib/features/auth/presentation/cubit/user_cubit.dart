// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mutazan_plus/core/databases/api/end_points.dart';
import 'package:mutazan_plus/core/databases/cache/cache_helper.dart';
import 'package:mutazan_plus/features/auth/data/models/sign_in_model.dart';
import 'package:mutazan_plus/features/auth/data/models/user_model.dart';

import 'package:mutazan_plus/features/auth/data/repositories/user_repository.dart';

import 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepository repo;
  final UserRepository userRepository;
  final CacheHelper cache;

  bool obscurePassword = true;
  final signInFormKey = GlobalKey<FormState>();
  final signInUsername = TextEditingController();
  final signInPassword = TextEditingController();

  UserCubit(
    this.repo,
    this.userRepository,
    this.obscurePassword,
    this.cache,
  ) : super(UserInitial());

  SignInModel? user;

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
      (err) => emit(SignInFailure(err)),
      (_) => emit(SignInSuccess()),
    );
  }

  Future<void> getUserProfile() async {
    emit(GetUserLoading());
    final Either<String, UserModel> res = await userRepository.getUserProfile();
    await res.fold(
      (err) {
        emit(GetUserFailure(errMessage: err));
      },
      (user) async {
        // حفظ في الكاش
        final cache = CacheHelper();
        await cache.saveData(key: ApiKey.username, value: user.name);
        await cache.saveData(key: ApiKey.email, value: user.email);
        await cache.saveData(key: ApiKey.phoneNumber, value: user.phone);
        await cache.saveData(key: ApiKey.address, value: user.address);
        await cache.saveData(key: ApiKey.profilePic, value: user.profilePic);
        emit(GetUserSuccess(user: user));
      },
    );
  }
    // getUserProfile() async {
    //   emit(GetUserLoading());
    //   final response = await userRepository.getUserProfile();
    //   response.fold(
    //     (errMessage) => emit(GetUserFailure(errMessage: errMessage)),
    //     (user) => emit(GetUserSuccess(user: user)),
    //   );
    // }
  
}
